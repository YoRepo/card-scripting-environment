#!/usr/bin/env python3
"""Bring mdpro3_scripts_named/ up to date with the game.

    python3 tools/update_corpus.py            # fetch, and say what would change
    python3 tools/update_corpus.py --apply    # ...and write it

The corpus is a FUNCTION OF ITS SOURCES: for every card the game has a
script for, one file, named after the card, holding the card's details as a
header comment and then the script untouched. This tool computes that whole
set and makes the directory equal to it — adds the cards that are new,
rewrites the ones whose details or script changed upstream, renames the
ones whose name changed, and removes the ones no source has any more (a
pre-release card that was released under another name leaves its
provisional file behind otherwise). Nothing is patched in place and nothing
is remembered between runs, so a run can be repeated, and the result does
not depend on which runs came before it.

Three modules, three questions:

  corpus_sources.py   WHERE cards come from — the upstream repositories,
                      how they are fetched, and the one rule choosing
                      between them (the official release first, the
                      pre-release pack for what it does not have yet).
  corpus_format.py    WHAT a corpus file is — the header's lines and the
                      file's name.
  update_corpus.py    this file: WHAT TO DO to the directory — name every
                      card's file (`name_files`), compare with what is there
                      (`plan`), write the difference (`apply`).

A FILE IS REWRITTEN ONLY WHEN IT CHANGED. The header's `Generated` line is
the moment that version of the file was made, so it is left out of the
comparison: a card whose details and script are what they were keeps its
file, stamp included, and an update's diff is exactly the cards that moved.

WHAT ELSE IS WRITTEN, so the repository never describes a corpus it no
longer holds: mdpro3_scripts_named/card_header_log.csv (one row per card:
passcode, name, file, database — the index to grep when a passcode is all
you have), mdpro3_scripts_named/corpus_sources.json (the upstream commit
each source was at — "how current is this corpus?" has an answer), and
effect_index.json, through tools/mine_effects.py, which the website's
Script Studio searches by.

WHAT IS NOT: custom_cards/ (hand-written, never touched), and anything in
the sibling Website-TEST repository that was mined from this corpus — the
tool names those at the end of a run instead.

USING FILES YOU ALREADY HAVE. Each source can be replaced by a local copy —
an MDPro4 install set to English holds all three (the official release as
Data/script.zip and Data/locales/en-US/cards.cdb, the pack as
Expansions/ygopro-super-pre.ypk):

    python3 tools/update_corpus.py --scripts PATH --cards-db PATH --prerelease PATH

and `--offline` reuses whatever the last run fetched. Fetching needs git on
the PATH and nothing else; the whole tool is the standard library.
"""
import argparse
import csv
import datetime
import io
import json
import os
import sys
from collections import namedtuple

import corpus_format as fmt
import corpus_sources as src
import mine_effects

REPO_ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
CORPUS_DIR = "mdpro3_scripts_named"
CACHE_DIR = ".corpus-cache"
LOG_FILE = "card_header_log.csv"
RECORD_FILE = "corpus_sources.json"
EXTENSION = ".lua"
# The engine reference's own record of the upstream commits it copies
# (reference/ygopro/README.md). Read here, never written: see reference_drift.
REFERENCE_RECORD = os.path.join("reference", "ygopro", "sources.json")
REFERENCE_LIBRARY = "ygopro-scripts"

# A plan that would leave the corpus this much smaller than it is has almost
# certainly been handed a wrong or half-fetched source — the card pool only
# grows. It is refused unless asked for by name (--allow-shrink).
SHRINK_LIMIT = 0.9

LOG_COLUMNS = ("source_file", "card_id", "card_name", "status", "output_path",
               "source_cdb")
WRITTEN = "written"
SKIPPED_NO_DETAILS = "skipped_no_card_data"
SKIPPED_SUPERSEDED = "skipped_released_under_same_name"


class UpdateError(Exception):
    """The update cannot go ahead. The message is the sentence to show."""


# ---- naming ----------------------------------------------------------------
def name_files(entries):
    """Give every entry its file name: ({file name: Entry}, superseded).

    A card's file is its name (corpus_format.file_stem). Two cards can ask
    for the same file — names are compared without regard to case, because
    the repository is checked out on Windows — and then:

      * a pre-release card asking for a released card's file IS that card:
        the pack has not dropped it yet. The released one is kept and the
        other comes back in `superseded`.
      * otherwise they are different printings under one name; the first —
        a card that is nobody's alias, then the lowest passcode — keeps the
        plain name and the others carry their passcode after it.

    A name that cannot be a file at all (empty once cleaned, or one Windows
    reserves) carries its passcode the same way."""
    def rank(entry):
        return (0 if entry.layer == src.OFFICIAL else 1,
                1 if entry.card.alias else 0, entry.card.id)

    groups = {}
    for entry in entries:
        stem = fmt.file_stem(entry.card.name)
        if not fmt.usable_stem(stem):
            stem = fmt.numbered_stem(stem, entry.card.id)
        groups.setdefault(stem.lower(), []).append((stem, entry))

    files, superseded, numbered = {}, [], []
    for key in sorted(groups):
        contenders = sorted(groups[key], key=lambda pair: rank(pair[1]))
        keeper_stem, keeper = contenders[0]
        files[keeper_stem + EXTENSION] = keeper
        for stem, entry in contenders[1:]:
            if entry.layer != src.OFFICIAL and keeper.layer == src.OFFICIAL:
                superseded.append(entry)
            else:
                numbered.append((stem, entry))
    taken = set(groups)
    for stem, entry in numbered:
        stem = fmt.numbered_stem(stem, entry.card.id)
        if stem.lower() in taken:
            raise UpdateError("Card %d would be filed as %s%s, and another card "
                              "already is." % (entry.card.id, stem, EXTENSION))
        taken.add(stem.lower())
        files[stem + EXTENSION] = entry
    return files, superseded


# ---- comparing -------------------------------------------------------------
def scan(corpus_dir):
    """What the corpus directory holds now: ({file name: Parsed}, foreign) —
    `foreign` being the .lua files this tool did not write and will not
    touch."""
    existing, foreign = {}, []
    if not os.path.isdir(corpus_dir):
        return existing, foreign
    for name in sorted(os.listdir(corpus_dir)):
        if not name.endswith(EXTENSION):
            continue
        with open(os.path.join(corpus_dir, name), "rb") as handle:
            parsed = fmt.parse(handle.read())
        if parsed is None:
            foreign.append(name)
        else:
            existing[name] = parsed
    return existing, foreign


# What an update will do, file by file. `writes` and `removes` are the whole
# of it; the lists after them say the same thing per card, for the report.
#   new       [(file, Entry)]             a card the corpus did not hold
#   renamed   [(old file, file, Entry)]   same passcode, the name changed
#   released  [(file, old passcode, Entry)]
#                                         same file, new passcode: the card
#                                         was pre-release and is now official
#   details   [file]                      the header changed
#   script    [file]                      the script changed
#   both      [file]
#   removed   [(file, Parsed)]            no source has the card any more
Plan = namedtuple("Plan", "writes removes new renamed released details script "
                          "both removed unchanged")


def plan(files, existing, generated):
    """Compare what should be there with what is. `generated` is the stamp
    the files this run writes will carry."""
    by_id = {parsed.card_id: name for name, parsed in existing.items()}
    writes, removes = {}, []
    new, renamed, released, details, script, both, removed = [], [], [], [], [], [], []
    unchanged = 0
    moved_from = set()
    for name in sorted(files):
        entry = files[name]
        had = existing.get(name)
        if had is not None:
            same_facts = had.facts == fmt.facts_of(entry.card, entry.source_db)
            same_script = had.script == entry.script
            if same_facts and same_script:
                unchanged += 1
                continue
            if had.card_id != entry.card.id:
                released.append((name, had.card_id, entry))
            elif same_script:
                details.append(name)
            elif same_facts:
                script.append(name)
            else:
                both.append(name)
        else:
            old = by_id.get(entry.card.id)
            if old is not None and old not in files:
                renamed.append((old, name, entry))
                moved_from.add(old)
            else:
                new.append((name, entry))
        writes[name] = fmt.render(entry.card, entry.source_db, generated, entry.script)
    for name in sorted(existing):
        if name not in files:
            removes.append(name)
            if name not in moved_from:
                removed.append((name, existing[name]))
    return Plan(writes, removes, new, renamed, released, details, script, both,
                removed, unchanged)


def apply(the_plan, corpus_dir):
    """Make the directory match the plan. Removals first: a card whose name
    changed only in its capitals is, on Windows, the same file."""
    os.makedirs(corpus_dir, exist_ok=True)
    for name in the_plan.removes:
        os.remove(os.path.join(corpus_dir, name))
    for name, content in the_plan.writes.items():
        with open(os.path.join(corpus_dir, name), "wb") as handle:
            handle.write(content)


# ---- the two records -------------------------------------------------------
def log_text(files, superseded, orphans):
    """card_header_log.csv: every card in the corpus by passcode, then what
    was left out and why. A function of the corpus alone, so it only changes
    when the corpus does."""
    out = io.StringIO()
    writer = csv.writer(out, lineterminator="\n")
    writer.writerow(LOG_COLUMNS)
    for name, entry in sorted(files.items(), key=lambda item: item[1].card.id):
        writer.writerow(["c%d.lua" % entry.card.id, entry.card.id,
                         fmt.one_line(entry.card.name), WRITTEN,
                         "%s/%s" % (CORPUS_DIR, name), entry.source_db])
    for entry in sorted(superseded, key=lambda entry: entry.card.id):
        writer.writerow(["c%d.lua" % entry.card.id, entry.card.id,
                         fmt.one_line(entry.card.name), SKIPPED_SUPERSEDED, "",
                         entry.source_db])
    for _layer, card_id in orphans:
        writer.writerow(["c%d.lua" % card_id, card_id, "", SKIPPED_NO_DETAILS, "", ""])
    return out.getvalue()


def record_text(provenance, files):
    """corpus_sources.json: which upstream commit each source was at, and
    how many cards each layer supplied."""
    counts = {}
    for entry in files.values():
        counts[entry.layer] = counts.get(entry.layer, 0) + 1
    counts["total"] = len(files)
    record = {
        "about": "Which upstream revisions %s/ was generated from. Written by "
                 "tools/update_corpus.py; do not edit by hand." % CORPUS_DIR,
        "cards": counts,
        "sources": provenance,
    }
    return json.dumps(record, indent=2, sort_keys=True) + "\n"


def _write_text(path, text):
    with open(path, "w", encoding="utf-8", newline="\n") as handle:
        handle.write(text)


# ---- the report ------------------------------------------------------------
def _listing(title, rows, show_all, out):
    if not rows:
        return
    limit = len(rows) if show_all else 12
    out("  %s" % title)
    for row in rows[:limit]:
        out("      " + row)
    if len(rows) > limit:
        out("      ... and %d more (--list shows every one)" % (len(rows) - limit))


def report(the_plan, files, existing, superseded, orphans, foreign, show_all, out):
    count = lambda rows: "{:>7,}".format(len(rows) if not isinstance(rows, int) else rows)
    out("")
    out("The corpus holds {:,} cards; the sources make {:,}.".format(
        len(existing), len(files)))
    for rows, label in (
            (the_plan.unchanged, "unchanged"),
            (the_plan.new, "new cards"),
            (the_plan.released, "released since — same file, the card's official passcode"),
            (the_plan.renamed, "renamed — the card's name changed upstream"),
            (the_plan.details, "details updated (the header)"),
            (the_plan.script, "script updated"),
            (the_plan.both, "details and script updated"),
            (the_plan.removed, "removed — no source has the card any more")):
        if rows or label == "unchanged":
            out("%s  %s" % (count(rows), label))
    out("")
    _listing("New:", ["%s  (%d)" % (name, entry.card.id)
                      for name, entry in the_plan.new], show_all, out)
    _listing("Released:", ["%s  (%d -> %d)" % (name, old, entry.card.id)
                           for name, old, entry in the_plan.released], show_all, out)
    _listing("Renamed:", ["%s -> %s" % (old, name)
                          for old, name, _ in the_plan.renamed], show_all, out)
    _listing("Details updated:", the_plan.details, show_all, out)
    _listing("Script updated:", the_plan.script, show_all, out)
    _listing("Details and script updated:", the_plan.both, show_all, out)
    _listing("Removed:", ["%s  (%d)" % (name, parsed.card_id)
                          for name, parsed in the_plan.removed], show_all, out)
    _listing("Left out — the pack still lists a card that has been released "
             "under the same name:",
             ["%s  (%d)" % (fmt.one_line(entry.card.name), entry.card.id)
              for entry in superseded], show_all, out)
    _listing("Left out — a script with no card details in any database, so "
             "no name to file it under:",
             ["c%d.lua  (%s)" % (card_id, layer) for layer, card_id in orphans],
             show_all, out)
    _listing("Not written by this tool, left alone:", foreign, show_all, out)
    unnamed = {}
    for entry in sorted(files.values(), key=lambda entry: entry.card.id):
        for bit in fmt.unnamed_bits(entry.card):
            unnamed.setdefault(bit, entry)
    _listing("Printed as a number — the game has a value corpus_format.py has "
             "no name for yet; add it there:",
             ["%s  (first on %s, %d)" % (bit, fmt.one_line(entry.card.name), entry.card.id)
              for bit, entry in sorted(unnamed.items())], show_all, out)


# ---- the engine reference --------------------------------------------------
def reference_drift(root, provenance):
    """A sentence when reference/ygopro/'s library is a copy of a different
    commit than the released scripts these sources are at, else None.

    utility.lua, procedure.lua and constant.lua live in the same upstream
    repository as the card scripts and are what those scripts are written
    against, so the two belong at one commit. This tool moves the scripts and
    deliberately NOT the reference — the engine is what the website's API
    docs were checked against, and refreshing it is a reviewed act (its
    README says how) — so the least it owes is to say when it has left the
    reference behind. Silent when either side has no commit to compare: a
    corpus made from local files, or a reference with no record."""
    scripts = (provenance.get(src.OFFICIAL_SCRIPTS.key) or {}).get("commit")
    try:
        with open(os.path.join(root, REFERENCE_RECORD), encoding="utf-8") as handle:
            pinned = json.load(handle)["sources"][REFERENCE_LIBRARY]["commit"]
    except (OSError, ValueError, KeyError, TypeError):
        return None
    if not scripts or not pinned or scripts == pinned:
        return None
    return ("The engine reference is behind these scripts: reference/ygopro/ is a "
            "copy of %s %s, and the released scripts are at %s. Its library is what "
            "they are written against — refresh it (reference/ygopro/README.md, "
            "\"Refreshing\")." % (REFERENCE_LIBRARY, str(pinned)[:10], scripts[:10]))


# ---- the command -----------------------------------------------------------
def _provenance(key, override, record):
    if override:
        # A file of the user's own: its name, never its path — this is
        # written into the repository.
        return {"local": os.path.basename(os.path.normpath(override))}
    return record.get(key) or {"local": src.CACHE_FILES[key]}


def _describe_source(provenance):
    if "commit" in provenance:
        return "%s %s %s (%s)" % (provenance["url"].replace("https://", ""),
                                  provenance["branch"], provenance["commit"][:10],
                                  provenance.get("committed", "")[:10])
    return "local file %s" % provenance["local"]


def run(arguments, out=print):
    root = os.path.abspath(arguments.root)
    corpus_dir = os.path.join(root, CORPUS_DIR)
    cache_dir = os.path.abspath(arguments.cache or os.path.join(root, CACHE_DIR))
    overrides = {src.OFFICIAL_SCRIPTS.key: arguments.scripts,
                 src.OFFICIAL_CARDS.key: arguments.cards_db,
                 src.PRERELEASE_PACK.key: arguments.prerelease}

    needed = [upstream for upstream in src.UPSTREAMS if not overrides[upstream.key]]
    record = {}
    if needed and arguments.offline:
        record = src.load_record(cache_dir)
    elif needed:
        out("Fetching the sources")
        record = src.fetch(cache_dir, needed, out)
    paths, provenance = {}, {}
    for upstream in src.UPSTREAMS:
        paths[upstream.key] = (overrides[upstream.key]
                               or os.path.join(cache_dir, src.CACHE_FILES[upstream.key]))
        provenance[upstream.key] = _provenance(upstream.key, overrides[upstream.key], record)
        if not os.path.exists(paths[upstream.key]):
            raise UpdateError(
                "No %s to read: %s does not exist.%s"
                % (upstream.what, paths[upstream.key],
                   " Run once without --offline to fetch it."
                   if arguments.offline and not overrides[upstream.key] else ""))

    scripts = src.read_scripts(paths[src.OFFICIAL_SCRIPTS.key])
    cards = src.read_cards(paths[src.OFFICIAL_CARDS.key])
    pack_scripts, pack_databases = src.read_pack(paths[src.PRERELEASE_PACK.key])
    layers = [src.official_layer(scripts, cards),
              src.prerelease_layer(pack_scripts, pack_databases)]
    entries, orphans = src.resolve(layers)
    files, superseded = name_files(entries)
    existing, foreign = scan(corpus_dir)

    out("")
    out("Sources")
    for upstream, detail in (
            (src.OFFICIAL_SCRIPTS, "{:,} scripts".format(len(scripts))),
            (src.OFFICIAL_CARDS, "{:,} cards".format(len(cards))),
            (src.PRERELEASE_PACK, "{:,} scripts, {:,} of them for cards not yet "
                                  "released".format(len(pack_scripts),
                                                    len(set(pack_scripts) - set(scripts))))):
        out("  %-22s %s — %s" % (upstream.what,
                                 _describe_source(provenance[upstream.key]), detail))

    blocked = sorted(name for name in foreign if name in files)
    if blocked:
        raise UpdateError(
            "%s already holds %s, which this tool did not write and a card "
            "now needs the name of. Move it out of the way first."
            % (CORPUS_DIR, ", ".join(blocked[:5])))
    if existing and len(files) < SHRINK_LIMIT * len(existing) and not arguments.allow_shrink:
        raise UpdateError(
            "The sources make {:,} cards but the corpus holds {:,}. A source is "
            "probably incomplete, so nothing was written; if the corpus really "
            "should shrink that far, say so with --allow-shrink."
            .format(len(files), len(existing)))

    generated = datetime.datetime.now().replace(microsecond=0).isoformat()
    the_plan = plan(files, existing, generated)
    report(the_plan, files, existing, superseded, orphans, foreign,
           arguments.list, out)

    drift = reference_drift(root, provenance)
    if drift:
        out("")
        out(drift)

    log = log_text(files, superseded, orphans)
    sources = record_text(provenance, files)
    if not arguments.apply:
        out("")
        out("Nothing was written — this was a dry run. Add --apply to write it."
            if the_plan.writes or the_plan.removes else
            "The corpus is up to date with these sources.")
        return 0
    apply(the_plan, corpus_dir)
    _write_text(os.path.join(corpus_dir, LOG_FILE), log)
    _write_text(os.path.join(corpus_dir, RECORD_FILE), sources)
    _, indexed = mine_effects.write_index(root, mine_effects.DEFAULT_OUT)
    out("")
    out("Wrote {:,} file(s) and removed {:,} in {}/, with {} and {}.".format(
        len(the_plan.writes), len(the_plan.removes), CORPUS_DIR, LOG_FILE, RECORD_FILE))
    out("Rebuilt {} ({:,} cards, custom_cards/ included).".format(
        mine_effects.DEFAULT_OUT, len(indexed)))
    if not (the_plan.writes or the_plan.removes):
        return 0
    out("")
    out("Not done here: what the sibling Website-TEST repository mined from this "
        "corpus is now a step behind it. When you want it caught up:")
    out("  in Website-TEST:  python3 tools/mine_card_codes.py --verify"
        "    (archetype names; --write adopts them)")
    out("  here:             python3 tools/mine_api.py --out "
        "../Website-TEST/static/data/scripter/api.json --merge")
    out("  here:             python3 tools/mine_constants.py --out "
        "../Website-TEST/static/data/scripter/constants.json")
    out("(Website-TEST's docs/script-builder/ has the checks that go with the last two.)")
    return 0


def main(argv=None):
    parser = argparse.ArgumentParser(
        description="Bring mdpro3_scripts_named/ up to date with the game. "
                    "Without --apply it only reports what would change.")
    parser.add_argument("--apply", action="store_true",
                        help="write the changes (default: a dry run)")
    parser.add_argument("--list", action="store_true",
                        help="list every affected card instead of the first few")
    parser.add_argument("--offline", action="store_true",
                        help="do not fetch; reuse what the last run fetched")
    parser.add_argument("--scripts", metavar="PATH",
                        help="official scripts from a folder or zip of c<id>.lua "
                             "instead of upstream (the game's Data/script.zip)")
    parser.add_argument("--cards-db", metavar="PATH",
                        help="official card details from this cards.cdb instead "
                             "of upstream (the game's Data/locales/en-US/cards.cdb)")
    parser.add_argument("--prerelease", metavar="PATH",
                        help="the pre-release pack from this .ypk instead of "
                             "upstream (the game's Expansions/ygopro-super-pre.ypk)")
    parser.add_argument("--allow-shrink", action="store_true",
                        help="go ahead even if the corpus would lose more than "
                             "a tenth of its cards")
    parser.add_argument("--root", default=REPO_ROOT,
                        help="the corpus repository (default: this one)")
    parser.add_argument("--cache", metavar="DIR",
                        help="where fetched sources are kept (default: "
                             "%s/ in the repository, git-ignored)" % CACHE_DIR)
    arguments = parser.parse_args(argv)
    for stream in (sys.stdout, sys.stderr):
        # A card's name can hold characters an old Windows console cannot
        # print; a report must not die of one.
        if hasattr(stream, "reconfigure"):
            stream.reconfigure(errors="replace")
    try:
        return run(arguments)
    except (UpdateError, src.SourceError) as exc:
        print("\nupdate_corpus: %s" % exc, file=sys.stderr)
        return 1


if __name__ == "__main__":
    sys.exit(main())
