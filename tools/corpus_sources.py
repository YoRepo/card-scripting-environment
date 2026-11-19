#!/usr/bin/env python3
"""Where the corpus comes from — the upstream sources, and the one rule for
choosing between them.

A card in the corpus is two things, a script and its details, and the game
ships them separately:

    the script     c<passcode>.lua            one file per card
    the details    a row of a card database   name, type, stats, text

THE SOURCES. There are three, in two layers, and they are named once, here
(`OFFICIAL_SCRIPTS`, `OFFICIAL_CARDS`, `PRERELEASE_PACK`):

  the official release
    github.com/mycard/ygopro-scripts, branch master — the script of every
      released card. MDPro4 ships exactly this as Data/script.zip (checked
      2026-11 against ElderLich/MDPro4_Data: the same 13,572 scripts, byte
      for byte).
    github.com/mycard/ygopro-database, locales/en-US_mdpro3/cards.cdb — the
      same cards' English details, one effect per line. It is the very file
      MDPro4 ships as Data/locales/en-US/cards.cdb. The repository's
      locales/en-US/cards.cdb is a different edition of the text and is NOT
      what the corpus is made from.

  the pre-release pack
    github.com/ElderLich/Pre-Release-Translations, EN/ygopro-super-pre.ypk —
      the English edition of MyCard's pre-release pack, which the MDPro
      clients install as Expansions/ygopro-super-pre.ypk for cards that are
      announced and scripted but not yet in the official release. A .ypk is
      a zip: `script/c<id>.lua` and, at its root, `test-release.cdb` (the
      new cards, under temporary passcodes from 100000000 up) and
      `test-update.cdb` (released cards the pack overrides while it is
      installed).

That these are the sources is not a guess. The corpus as first generated
(2026-07-12) is reproduced from them: every official script is byte for
byte ygopro-scripts as of its commit df337be9, every pre-release script is
the pack's (v280), and the headers come out of ygopro-database f3d9f81e and
the pack's two databases — see corpus_format.py for the header's own proof.

THE RULE. The official release is asked first, for everything; the pack
fills in only what the official release does not have. `resolve` is that
sentence, and nothing else decides which source a card comes from. So:

  * a released card is its released script beside its released details.
    The pack also carries newer copies of several hundred released scripts
    and, in test-update.cdb, overriding rows for released cards; neither is
    used. The first generation took its headers from test-update.cdb where
    it could (275 cards) while taking those cards' scripts from the
    official release — a script beside details that were not its own — and
    the pack's rows for released cards are the poorer text besides:
    measured on the 2026-11 pack, 350 of its 400 override rows word a card
    differently from the official database, and for 322 of those the only
    difference is that the line breaks between effects are gone.
  * a pre-release card is the pack's script beside the pack's details.
  * when a pre-release card is released, its passcode changes and it moves
    layers by itself: the official release has it, the pack drops it.
  * a released script whose details the official database does not have
    yet takes them from the pack if the pack has them (the two official
    repositories are updated separately), and is otherwise left out and
    reported — a card cannot be filed without a name.

Scripts are read as BYTES and never through a git checkout: a checkout on
Windows rewrites line endings, and a corpus file's script is upstream's,
byte for byte. `fetch` takes each blob straight out of the object store.

Everything read here is somebody else's data. It is parsed, never run; no
archive member is ever written to a path taken from its name; and what a
card's name may do to a file name or a header is corpus_format.py's concern.
"""
import io
import json
import os
import re
import shutil
import sqlite3
import stat
import subprocess
import sys
import tempfile
import zipfile
from collections import namedtuple
from pathlib import Path

from corpus_format import Card

# ---- the upstream sources --------------------------------------------------
# `path` is the one file wanted from the repository; None means its scripts.
Upstream = namedtuple("Upstream", "key what url branch path")

OFFICIAL_SCRIPTS = Upstream(
    "official-scripts", "official scripts",
    "https://github.com/mycard/ygopro-scripts", "master", None)
OFFICIAL_CARDS = Upstream(
    "official-cards", "official card details",
    "https://github.com/mycard/ygopro-database", "master",
    "locales/en-US_mdpro3/cards.cdb")
PRERELEASE_PACK = Upstream(
    "prerelease-pack", "pre-release pack",
    "https://github.com/ElderLich/Pre-Release-Translations", "main",
    "EN/ygopro-super-pre.ypk")
UPSTREAMS = (OFFICIAL_SCRIPTS, OFFICIAL_CARDS, PRERELEASE_PACK)

# What each is called once it is in the cache directory.
CACHE_FILES = {
    OFFICIAL_SCRIPTS.key: "official-scripts.zip",
    OFFICIAL_CARDS.key: "cards.cdb",
    PRERELEASE_PACK.key: "ygopro-super-pre.ypk",
}
CACHE_RECORD = "sources.json"

# The two layers' names, as they appear in reports and the sources record.
OFFICIAL = "official"
PRERELEASE = "pre-release"
OFFICIAL_DB_NAME = "cards.cdb"

_SCRIPT_NAME = re.compile(r"^c(\d+)\.lua$")
_DB_NAME = re.compile(r"^[A-Za-z0-9._-]+\.cdb$")

# Bounds on what one archive member may be. Nothing real comes near them
# (the longest script is tens of kilobytes, the largest database 8 MB); they
# are there so a damaged or hostile archive is refused with a sentence
# instead of filling the machine's memory.
MAX_SCRIPT_BYTES = 2 * 1024 * 1024
MAX_DB_BYTES = 512 * 1024 * 1024


class SourceError(Exception):
    """A source could not be fetched or read. The message is the sentence to
    show; the updater prints it and stops."""


# ---- reading ---------------------------------------------------------------
def _zip_member(archive, info, limit):
    if info.file_size > limit:
        raise SourceError("%s is %d bytes — more than any real one; the archive "
                          "looks damaged." % (info.filename, info.file_size))
    with archive.open(info) as handle:
        data = handle.read(limit + 1)
    if len(data) > limit:
        raise SourceError("%s unpacks past its stated size; the archive looks "
                          "damaged." % info.filename)
    return data


def _scripts_in_zip(archive, where):
    """{passcode: bytes} for every member named c<digits>.lua, in whatever
    folder (the cache's zip is flat, a .ypk keeps them in script/, the
    game's script.zip likewise)."""
    scripts = {}
    for info in archive.infolist():
        if info.is_dir():
            continue
        # (Some Windows tools write a zip's folders with backslashes.)
        match = _SCRIPT_NAME.match(info.filename.replace("\\", "/").rsplit("/", 1)[-1])
        if not match:
            continue
        card_id = int(match.group(1))
        if card_id in scripts:
            raise SourceError("%s holds c%d.lua twice (in two folders) — which "
                              "one is meant cannot be told." % (where, card_id))
        scripts[card_id] = _zip_member(archive, info, MAX_SCRIPT_BYTES)
    return scripts


def read_scripts(path):
    """{passcode: bytes} for every card script at `path` — a folder of
    c<id>.lua files, or a zip of them. Anything not named like a card script
    (constant.lua, utility.lua, a LICENSE) is not a card and is not read."""
    path = str(path)
    if os.path.isdir(path):
        scripts = {}
        for entry in os.scandir(path):
            match = _SCRIPT_NAME.match(entry.name)
            # A symbolic link is not followed: a script is the bytes in the
            # folder, never a file the folder points at.
            if not match or not entry.is_file(follow_symlinks=False):
                continue
            if entry.stat(follow_symlinks=False).st_size > MAX_SCRIPT_BYTES:
                raise SourceError("%s is larger than any real script." % entry.path)
            with open(entry.path, "rb") as handle:
                scripts[int(match.group(1))] = handle.read()
        return scripts
    try:
        with zipfile.ZipFile(path) as archive:
            return _scripts_in_zip(archive, os.path.basename(path))
    except (OSError, zipfile.BadZipFile) as exc:
        raise SourceError("Could not read scripts from %s: %s" % (path, exc))


def read_cards(path):
    """{passcode: Card} for every row of a ygopro card database."""
    try:
        uri = Path(path).resolve().as_uri() + "?mode=ro"
        connection = sqlite3.connect(uri, uri=True)
    except (sqlite3.Error, ValueError, OSError) as exc:
        raise SourceError("Could not open the card database %s: %s" % (path, exc))
    try:
        # A database with one mis-encoded name is still a database.
        connection.text_factory = lambda raw: raw.decode("utf-8", "replace")
        rows = connection.execute(
            "SELECT d.id, d.ot, d.alias, d.setcode, d.type, d.atk, d.def,"
            " d.level, d.race, d.attribute, t.name, t.desc"
            " FROM datas d JOIN texts t ON t.id = d.id")
        cards = {}
        for row in rows:
            numbers = [int(value or 0) for value in row[:10]]
            cards[numbers[0]] = Card(*numbers, name=row[10] or "", desc=row[11] or "")
        return cards
    except (sqlite3.Error, ValueError, TypeError) as exc:
        raise SourceError("%s is not a card database this tool can read: %s"
                          % (path, exc))
    finally:
        connection.close()


def read_pack(path):
    """A pre-release pack (.ypk) as (scripts, databases): its card scripts,
    and every card database at its root as [(file name, {passcode: Card})],
    by file name — test-release.cdb, then test-update.cdb."""
    try:
        with zipfile.ZipFile(path) as archive:
            scripts = _scripts_in_zip(archive, os.path.basename(str(path)))
            databases = []
            with tempfile.TemporaryDirectory(prefix="corpus-pack-") as scratch:
                members = sorted(
                    (info for info in archive.infolist()
                     if not info.is_dir() and _DB_NAME.match(info.filename)),
                    key=lambda info: info.filename)
                for number, info in enumerate(members):
                    # SQLite opens files, not bytes — so the database is
                    # written out, under a name of ours, never the member's.
                    copy = os.path.join(scratch, "%d.cdb" % number)
                    with open(copy, "wb") as handle:
                        handle.write(_zip_member(archive, info, MAX_DB_BYTES))
                    databases.append((info.filename, read_cards(copy)))
            return scripts, databases
    except (OSError, zipfile.BadZipFile) as exc:
        raise SourceError("Could not read the pre-release pack %s: %s" % (path, exc))


# ---- the rule --------------------------------------------------------------
# A layer: its name, its scripts, and its databases in the order they are
# asked. An entry: one card the corpus will hold — its details, the file name
# of the database they came from, the layer its SCRIPT came from, the script.
Layer = namedtuple("Layer", "name scripts databases")
Entry = namedtuple("Entry", "card source_db layer script")


def official_layer(scripts, cards):
    return Layer(OFFICIAL, scripts, [(OFFICIAL_DB_NAME, cards)])


def prerelease_layer(scripts, databases):
    return Layer(PRERELEASE, scripts, list(databases))


def resolve(layers):
    """Every card the layers can supply, as (entries, orphans).

    THE RULE: a card's script is the first layer's that has one, and its
    details the first layer's that has them — `layers` in order, official
    first. A script with details in no layer cannot be named, so it is not
    an entry: it comes back in `orphans` as (layer name, passcode), for the
    updater to report. (The reverse — details without a script — is a card
    with no script to show: a Normal monster, a token. Not the corpus's.)"""
    entries, orphans, seen = [], [], set()
    for layer in layers:
        for card_id in sorted(layer.scripts):
            if card_id in seen:
                continue
            seen.add(card_id)
            found = None
            for candidate in layers:
                for db_name, cards in candidate.databases:
                    if card_id in cards:
                        found = (cards[card_id], db_name)
                        break
                if found:
                    break
            if found:
                entries.append(Entry(found[0], found[1], layer.name,
                                     layer.scripts[card_id]))
            else:
                orphans.append((layer.name, card_id))
    entries.sort(key=lambda entry: entry.card.id)
    return entries, sorted(orphans)


# ---- fetching --------------------------------------------------------------
# The cache directory holds three plain files — the official scripts as one
# zip, the official database, the pack — and sources.json, which says which
# upstream commit each was taken from. No git state is kept: a source is
# re-read only when its branch has moved, by a throwaway shallow clone.

# Long enough for the 40 MB pack on a slow line; short enough that a dead
# connection ends in a sentence instead of a tool that never returns.
GIT_TIMEOUT_SECONDS = 900


def _git(arguments, cwd=None, feed=None):
    # Never a prompt: a repository that has moved or gone private must fail
    # here, not wait on a password nobody is there to type.
    environment = dict(os.environ, GIT_TERMINAL_PROMPT="0")
    try:
        done = subprocess.run(["git"] + list(arguments), cwd=cwd, input=feed,
                              stdout=subprocess.PIPE, stderr=subprocess.PIPE,
                              env=environment, timeout=GIT_TIMEOUT_SECONDS)
    except FileNotFoundError:
        raise SourceError("git is not installed (or not on PATH); it is how the "
                          "upstream sources are fetched.")
    except subprocess.TimeoutExpired:
        raise SourceError("git %s did not finish in %d minutes; check the "
                          "connection and run again."
                          % (arguments[0], GIT_TIMEOUT_SECONDS // 60))
    if done.returncode:
        detail = done.stderr.decode("utf-8", "replace").strip().splitlines()
        raise SourceError("git %s failed: %s"
                          % (arguments[0], detail[-1] if detail else "no message"))
    return done.stdout


def _remove_tree(path):
    """shutil.rmtree, for a git clone on Windows too — git marks its object
    files read-only, and Windows refuses to delete those."""
    def retry(function, target, _info):
        os.chmod(target, stat.S_IWRITE)
        function(target)
    if sys.version_info >= (3, 12):
        shutil.rmtree(path, onexc=retry)       # `onerror` is on its way out
    else:
        shutil.rmtree(path, onerror=retry)


def remote_commit(upstream):
    """The commit the upstream branch points at right now."""
    answer = _git(["ls-remote", upstream.url, "refs/heads/" + upstream.branch])
    fields = answer.decode("ascii", "replace").split()
    if not fields or not re.match(r"^[0-9a-f]{40,64}$", fields[0]):
        raise SourceError("%s has no branch %r." % (upstream.url, upstream.branch))
    return fields[0]


def _clone(upstream, target):
    """A bare, one-commit clone: no working tree, so nothing is checked out,
    converted or linked. For a one-file source the blobs are left behind and
    only the wanted one is fetched when it is read."""
    command = ["clone", "--quiet", "--bare", "--depth", "1", "--single-branch",
               "--branch", upstream.branch]
    if upstream.path:
        command.append("--filter=blob:none")
    _git(command + [upstream.url, target])


def _all_scripts_zip(clone, destination):
    """Every c<id>.lua at the root of the clone's commit, read straight from
    the object store into one zip — built the same way every time, so the
    same commit always yields the same file."""
    listing = _git(["ls-tree", "-z", "HEAD"], cwd=clone).split(b"\0")
    wanted = []
    for row in listing:
        if not row:
            continue
        meta, _, name = row.partition(b"\t")
        mode, kind, sha = meta.split()[:3]
        name = name.decode("utf-8", "replace")
        # A regular file only: mode 120000 is a symbolic link.
        if kind == b"blob" and mode in (b"100644", b"100755") and _SCRIPT_NAME.match(name):
            wanted.append((name, sha))
    if not wanted:
        raise SourceError("The scripts repository holds no c<id>.lua files.")
    wanted.sort()
    raw = _git(["cat-file", "--batch"], cwd=clone,
               feed=b"".join(sha + b"\n" for _, sha in wanted))
    stream = io.BytesIO(raw)
    with zipfile.ZipFile(destination, "w", zipfile.ZIP_DEFLATED) as archive:
        for name, sha in wanted:
            head = stream.readline().split()
            if len(head) != 3 or head[0] != sha or head[1] != b"blob":
                raise SourceError("git returned something other than %s." % name)
            data = stream.read(int(head[2]))
            stream.read(1)                       # the newline after each object
            archive.writestr(zipfile.ZipInfo(name, (1980, 1, 1, 0, 0, 0)), data,
                             compress_type=zipfile.ZIP_DEFLATED)
    return len(wanted)


def _one_file(clone, upstream, destination):
    data = _git(["cat-file", "blob", "HEAD:" + upstream.path], cwd=clone)
    with open(destination, "wb") as handle:
        handle.write(data)


_CLONE_PREFIX = "clone-"
_PARTIAL_SUFFIX = ".part"


def load_record(cache_dir):
    """The cache's sources.json — {source key: {url, branch, path, commit,
    committed}} — or {} when there is none yet."""
    try:
        with open(os.path.join(cache_dir, CACHE_RECORD), encoding="utf-8") as handle:
            record = json.load(handle)
        return record if isinstance(record, dict) else {}
    except (OSError, ValueError):
        return {}


def fetch(cache_dir, upstreams=UPSTREAMS, say=print):
    """Bring the cache directory up to date with the upstream sources asked
    for and return its record. A source whose branch has not moved since it
    was last fetched is left alone, so a second run costs three small
    questions."""
    os.makedirs(cache_dir, exist_ok=True)
    for leftover in os.listdir(cache_dir):
        # What a run that was interrupted left behind.
        path = os.path.join(cache_dir, leftover)
        if leftover.startswith(_CLONE_PREFIX) and os.path.isdir(path):
            _remove_tree(path)
        elif leftover.endswith(_PARTIAL_SUFFIX) and os.path.isfile(path):
            os.remove(path)
    record = load_record(cache_dir)
    for upstream in upstreams:
        destination = os.path.join(cache_dir, CACHE_FILES[upstream.key])
        commit = remote_commit(upstream)
        have = record.get(upstream.key) or {}
        if (have.get("commit") == commit and have.get("url") == upstream.url
                and have.get("path") == upstream.path and os.path.isfile(destination)):
            say("  %-22s unchanged since last fetch (%s)" % (upstream.what, commit[:10]))
            continue
        say("  %-22s fetching %s ..." % (upstream.what, commit[:10]))
        clone = tempfile.mkdtemp(prefix=_CLONE_PREFIX, dir=cache_dir)
        try:
            _clone(upstream, clone)
            cloned = _git(["rev-parse", "HEAD"], cwd=clone).decode("ascii").strip()
            committed = _git(["log", "-1", "--format=%cI"], cwd=clone).decode("ascii").strip()
            partial = destination + _PARTIAL_SUFFIX
            if upstream.path:
                _one_file(clone, upstream, partial)
            else:
                _all_scripts_zip(clone, partial)
            os.replace(partial, destination)
        finally:
            _remove_tree(clone)
        # `cloned`, not `commit`: the branch may have moved between the
        # question and the clone, and the record must name what was read.
        record[upstream.key] = {"url": upstream.url, "branch": upstream.branch,
                                "path": upstream.path, "commit": cloned,
                                "committed": committed}
        with open(os.path.join(cache_dir, CACHE_RECORD), "w", encoding="utf-8",
                  newline="\n") as handle:
            json.dump(record, handle, indent=2, sort_keys=True)
            handle.write("\n")
    return record
