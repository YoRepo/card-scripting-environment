# path: tests/unit_update_corpus.py
"""Unit tests for the corpus updater — tools/corpus_format.py (what a corpus
file is), tools/corpus_sources.py (where cards come from) and
tools/update_corpus.py (what to do to the directory). No network: every
source is built here, in a temporary folder.

§1 and §2 are the point of the file: THE FORMAT IS HELD TO THE CORPUS. The
format was recovered from files a lost tool wrote, so its contract is those
files. tests/fixtures/first_generation.json is a covering sample of them —
real database rows, with the header and the file name the first generation
wrote for each, one for every type, race, attribute and Link arrow the game
has — and the format must write each of them exactly. A change that fails
here rewrites thousands of existing files; that is what the failure means.

§3 what a header refuses to let a card's own text do, §4 reading a file
back, §5 reading the sources, §6 THE RULE that chooses between them, §7 file
names that collide, §8 the update itself on a small corpus (every kind of
change, that a second run changes nothing, the refusals), §9 fetching from
git — against repositories made here — with §9b the note an update owes when
it leaves the engine reference behind, and §10 the real corpus directory:
every file in it is one this tool reads and would name the same way, and
the three things derived from it (the log, the sources record, the effect
index) describe the corpus that is actually there.

Run: python3 tests/unit_update_corpus.py
"""

import contextlib
import csv
import io
import json
import os
import shutil
import sqlite3
import subprocess
import sys
import tempfile
import zipfile

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
sys.path.insert(0, os.path.join(ROOT, "tools"))

import corpus_format as fmt                                  # noqa: E402
import corpus_sources as src                                 # noqa: E402
import update_corpus as up                                   # noqa: E402

failures = 0


def check(name, ok, extra=""):
    global failures
    print(("PASS: " if ok else "FAIL: ") + name
          + ("" if ok or not extra else " — " + str(extra)[:400]))
    if not ok:
        failures += 1


with open(os.path.join(ROOT, "tests", "fixtures", "first_generation.json"),
          encoding="utf-8") as handle:
    FIRST = json.load(handle)

SCRATCH = tempfile.mkdtemp(prefix="corpus-test-")


# ------------------------------------------------------------------ builders
def card(card_id, name, **fields):
    """A Card with an Effect monster's defaults, for the tests that are not
    about the header."""
    values = dict(id=card_id, ot=3, alias=0, setcode=0, type=0x21, atk=1000,
                  defense=1000, level=4, race=0x1, attribute=0x1, name=name,
                  desc="Text of %s." % name)
    values.update(fields)
    return fmt.Card(**values)


def make_cdb(path, cards):
    """A card database with the game's own schema."""
    connection = sqlite3.connect(path)
    connection.execute(
        "CREATE TABLE datas(id integer primary key, ot integer, alias integer,"
        " setcode integer, type integer, atk integer, def integer,"
        " level integer, race integer, attribute integer, category integer)")
    connection.execute(
        "CREATE TABLE texts(id integer primary key, name text, desc text, "
        + ", ".join("str%d text" % n for n in range(1, 17)) + ")")
    for c in cards:
        connection.execute(
            "INSERT INTO datas VALUES (?,?,?,?,?,?,?,?,?,?,0)",
            (c.id, c.ot, c.alias, c.setcode, c.type, c.atk, c.defense, c.level,
             c.race, c.attribute))
        connection.execute("INSERT INTO texts VALUES (?,?,?" + ",''" * 16 + ")",
                           (c.id, c.name, c.desc))
    connection.commit()
    connection.close()
    return path


def make_zip(path, members):
    with zipfile.ZipFile(path, "w") as archive:
        for name, data in members.items():
            archive.writestr(name, data)
    return path


def make_pack(path, scripts, databases):
    """A .ypk: script/c<id>.lua, and the databases at its root."""
    members = {"script/c%d.lua" % card_id: data for card_id, data in scripts.items()}
    members["script/constant.lua"] = b"-- not a card\n"
    members["pics/1.jpg"] = b"not a picture"
    for name, cards in databases.items():
        scratch = tempfile.mkdtemp(prefix="pack-db-", dir=SCRATCH)
        with open(make_cdb(os.path.join(scratch, name), cards), "rb") as handle:
            members[name] = handle.read()
    return make_zip(path, members)


def script_of(card_id, note=""):
    return ("--%s\nfunction c%d.initial_effect(c)\nend\n" % (note or card_id, card_id)).encode()


# ------------------------------------------------------- §1 the file name
print("--- §1 a card's file is named as the corpus names it")
for name, want in FIRST["names"]:
    got = fmt.file_stem(name) + ".lua"
    check("%r -> %s" % (name, want), got == want, got)
check("the characters Windows refuses are dropped, every one",
      fmt.file_stem('a<b>c:d"e/f\\g|h?i*j') == "abcdefghij")
check("runs of any white space become one underscore, the ends none",
      fmt.file_stem("  Two   words\tand\na tab ") == "Two_words_and_a_tab")
check("a control character cannot reach a file name",
      fmt.file_stem("Bell\x07 and\x00 null") == "Bell_and_null")
check("a leading dot would hide the file from every *.lua glob; it goes",
      fmt.file_stem(".hidden") == "hidden" and fmt.file_stem("..") == "")
check("a name of nothing but dropped characters leaves no stem, and says so",
      fmt.file_stem("???") == "" and not fmt.usable_stem(""))
check("a device name Windows reserves is not usable, in any capitals, with any tail",
      not fmt.usable_stem("CON") and not fmt.usable_stem("nul")
      and not fmt.usable_stem("Com1.5") and fmt.usable_stem("Console")
      and fmt.usable_stem("Aux_Gate"))
check("the numbered stem is the way out for both",
      fmt.numbered_stem("", 123) == "card_123" and fmt.numbered_stem("CON", 123) == "CON_123")

# --------------------------------------------------------- §2 the header
print("--- §2 the header, held to the files the first generation wrote")
for sample in FIRST["headers"]:
    c = fmt.Card(**sample["card"])
    got = list(fmt.facts_of(c, sample["source_db"]))
    label = "%s (%s)" % (sample["file"], sample["why"])
    if got != sample["header"]:
        differing = [(a, b) for a, b in zip(got, sample["header"]) if a != b][:2]
        check(label, False, differing or "length %d vs %d" % (len(got), len(sample["header"])))
    else:
        check(label, True)
    check("  …and its file name", fmt.file_stem(c.name) + ".lua" == sample["file"],
          fmt.file_stem(c.name))

covered = {"type": 0, "race": 0, "attribute": 0, "arrow": 0}
for sample in FIRST["headers"]:
    c = fmt.Card(**sample["card"])
    covered["type"] |= c.type
    if c.type & fmt.TYPE_MONSTER:
        covered["race"] |= c.race
        covered["attribute"] |= c.attribute
        if c.type & fmt.TYPE_LINK:
            covered["arrow"] |= c.defense
missing_types = [name for bit, name in fmt.TYPE_NAMES
                 if not covered["type"] & bit and name not in ("Trap Monster", "Token")]
check("the sample pins every type name a scripted card can carry", not missing_types,
      missing_types)
check("…every race", all(covered["race"] & bit for bit, _ in fmt.RACE_NAMES),
      [name for bit, name in fmt.RACE_NAMES if not covered["race"] & bit])
check("…every attribute", all(covered["attribute"] & bit for bit, _ in fmt.ATTRIBUTE_NAMES))
check("…and every Link arrow", all(covered["arrow"] & bit for bit, _ in fmt.LINK_ARROW_NAMES))

corrected = [s for s in FIRST["headers"] if "corrected" in s]
check("the two deliberate departures from the first generation are both in the sample",
      len(corrected) == 2, [s["file"] for s in corrected])
zero = next(s for s in FIRST["headers"] if s["file"] == "Supreme_King_Gate_Zero.lua")
check("a Pendulum monster with scales of 0 still has its scale line",
      "-- Pendulum Scale: L0 / R0" in zero["header"]
      and "-- Pendulum Scale: L0 / R0" in fmt.header_lines(fmt.Card(**zero["card"]), "cards.cdb", "now"))
albion = next(s for s in FIRST["headers"] if s["file"] == "Albion_the_Branded_Dragon.lua")
check("ot bit 0x8 is Simplified Chinese — a legal card is never called Illegal",
      "-- Scope: OCG / TCG / Simplified Chinese" in fmt.header_lines(
          fmt.Card(**albion["card"]), "test-update.cdb", "now"))

lines = fmt.header_lines(card(7, "Seven"), "cards.cdb", "2026-01-02T03:04:05")
check("the header opens and closes on its markers, with the stamp second",
      lines[0] == fmt.START_LINE and lines[-1] == fmt.END_LINE
      and lines[1] == "-- Generated: 2026-01-02T03:04:05")
whole = fmt.render(card(7, "Seven"), "cards.cdb", "now", b"--script\r\nlocal x=1")
check("a file is the header, one blank line, and the script's own bytes to the last",
      whole.endswith(b"\n" + fmt.END_LINE.encode() + b"\n\n--script\r\nlocal x=1"))

wrapped = fmt.text_lines("word " * 30 + "non-Link " * 3)
check("text wraps at %d characters, and never beside a hyphen" % fmt.TEXT_WIDTH,
      all(len(row) <= fmt.TEXT_WIDTH + 3 for row in wrapped)
      and not any(row.endswith("-") for row in wrapped), wrapped)
check("the database's own line breaks are kept, a blank one as a bare comment",
      fmt.text_lines("First.\r\n\r\nSecond.\rThird.\nFourth.")
      == ["-- First.", "--", "-- Second.", "-- Third.", "-- Fourth."])
check("a Spell says nothing about attribute, race, level or stats",
      not [row for row in fmt.header_lines(card(8, "A Spell", type=0x2), "cards.cdb", "now")
           if row.startswith(("-- Attribute", "-- Race", "-- Level", "-- ATK"))])
check("set codes unpack lowest first, sixteen bits each, even from a negative column",
      fmt.setcodes(card(9, "x", setcode=0x0046_0136)) == [0x136, 0x46]
      and fmt.setcodes(card(9, "x", setcode=-1)) == [0xFFFF] * 4)

# ------------------------------------------ §3 what a card's text cannot do
print("--- §3 nothing in a card's own text can leave the comment")
hostile = card(66, "Line one\nos.execute('x')\r\n--[[ __CARD_HEADER_END__ ]]",
               desc="ok\nfunction evil() end\n\x0b\x0c also")
lines = fmt.header_lines(hostile, "cards.cdb\nprint(1)", "now\nprint(2)")
check("every line of a header is a comment, whatever the name, text, source or stamp hold",
      all(row.startswith("--") for row in lines),
      [row for row in lines if not row.startswith("--")])
check("…and the header is still exactly one block: markers first and last only",
      [i for i, row in enumerate(lines) if row == fmt.END_LINE] == [len(lines) - 1]
      and lines.count(fmt.START_LINE) == 1)
odd = card(67, "Odd", type=0x21 | 0x8, race=0x4000000, attribute=0x80, ot=0x13)
rows = fmt.header_lines(odd, "cards.cdb", "now")
check("a bit with no name is printed as its number, never dropped",
      "-- Type: Monster / Effect / 0x8" in rows and "-- Race: 0x4000000" in rows
      and "-- Attribute: 0x80" in rows and "-- Scope: OCG / TCG / 0x10" in rows, rows[4:9])
check("…and unnamed_bits says which, so the update can ask for a name",
      fmt.unnamed_bits(odd) == ["type 0x8", "scope 0x10", "attribute 0x80", "race 0x4000000"],
      fmt.unnamed_bits(odd))
check("a card the game has today has none",
      not any(fmt.unnamed_bits(fmt.Card(**s["card"])) for s in FIRST["headers"]))

# -------------------------------------------------- §4 reading a file back
print("--- §4 a file reads back as what was written")
c = fmt.Card(**FIRST["headers"][0]["card"])
content = fmt.render(c, "cards.cdb", "2026-07-12T02:17:44", b"--body\n")
back = fmt.parse(content)
check("parse returns the passcode, name, source, stamp and script",
      back is not None and back.card_id == c.id and back.name == c.name
      and back.source_db == "cards.cdb" and back.generated == "2026-07-12T02:17:44"
      and back.script == b"--body\n", back)
check("…and its facts are the header without the stamp",
      back.facts == fmt.facts_of(c, "cards.cdb")
      and not any(row.startswith(fmt.GENERATED_FIELD) for row in back.facts))
later = fmt.parse(fmt.render(c, "cards.cdb", "2027-01-01T00:00:00", b"--body\n"))
check("the same card written at another time has the same facts — the stamp is not a change",
      later.facts == back.facts and later.generated != back.generated)
says = card(70, "Says Generated", desc="Once per turn.\nGenerated: by this effect, draw 1 card.")
check("a card whose own text starts a line with \"Generated:\" keeps that line — only the stamp is the stamp",
      fmt.parse(fmt.render(says, "cards.cdb", "now", b"x")).facts == fmt.facts_of(says, "cards.cdb")
      and "-- Generated: by this effect, draw 1 card." in fmt.facts_of(says, "cards.cdb"))
check("a script with no header is not a corpus file", fmt.parse(b"--plain\nlocal x\n") is None)
check("…nor is a hand-written header this module cannot follow (custom_cards/ is not its)",
      fmt.parse((fmt.START_LINE + "\n-- Card: X\n" + fmt.END_LINE + "\n\nbody").encode()) is None)
check("a script that itself quotes the end marker does not confuse the split",
      fmt.parse(fmt.render(c, "cards.cdb", "now",
                           ("--x\n" + fmt.END_LINE + "\n\nmore").encode())).script
      == ("--x\n" + fmt.END_LINE + "\n\nmore").encode())

# -------------------------------------------------- §5 reading the sources
print("--- §5 the sources are read as they are, and only what is a card")
folder = os.path.join(SCRATCH, "scripts")
os.makedirs(folder)
crlf = b"--one\r\nfunction c1.initial_effect(c)\r\nend\r\n"
for name, data in (("c1.lua", crlf), ("c22.lua", b"--two\n"), ("constant.lua", b"x"),
                   ("utility.lua", b"x"), ("c3.txt", b"x"), ("xc4.lua", b"x"),
                   ("LICENSE", b"x")):
    with open(os.path.join(folder, name), "wb") as handle:
        handle.write(data)
with open(os.path.join(SCRATCH, "secret.txt"), "wb") as handle:
    handle.write(b"not a script")
linked = True
try:
    os.symlink(os.path.join(SCRATCH, "secret.txt"), os.path.join(folder, "c5.lua"))
except (OSError, NotImplementedError, AttributeError):
    linked = False
got = src.read_scripts(folder)
check("a folder yields the c<id>.lua files and nothing else", sorted(got) == [1, 22], sorted(got))
check("…bytes untouched — a script's line endings are upstream's", got[1] == crlf)
if linked:
    check("…and a symbolic link named like a script is not followed", 5 not in got)
else:
    print("SKIP: this system cannot make a symbolic link")
flat = make_zip(os.path.join(SCRATCH, "flat.zip"), {"c1.lua": crlf, "readme.txt": b"x"})
nested = make_zip(os.path.join(SCRATCH, "nested.zip"),
                  {"script/c1.lua": crlf, "script/constant.lua": b"x", "script/c22.lua": b"--two\n"})
check("a zip of scripts reads the same, flat or under script/ like the game's own",
      src.read_scripts(flat) == {1: crlf} and src.read_scripts(nested) == got)
slashed = make_zip(os.path.join(SCRATCH, "slashed.zip"), {"script\\c1.lua": crlf})
check("…or with the backslashes some Windows tools write", src.read_scripts(slashed) == {1: crlf})
twice = make_zip(os.path.join(SCRATCH, "twice.zip"), {"a/c1.lua": b"x", "b/c1.lua": b"y"})
try:
    src.read_scripts(twice)
    check("one passcode in two folders of a zip is refused", False)
except src.SourceError as exc:
    check("one passcode in two folders of a zip is refused, in a sentence", "c1.lua twice" in str(exc), exc)
try:
    src.read_scripts(os.path.join(SCRATCH, "secret.txt"))
    check("a file that is not a zip is refused", False)
except src.SourceError as exc:
    check("a file that is not a zip is refused, in a sentence", "Could not read scripts" in str(exc), exc)

sample = [fmt.Card(**s["card"]) for s in FIRST["headers"][:6]]
database = make_cdb(os.path.join(SCRATCH, "cards.cdb"), sample)
read = src.read_cards(database)
check("a card database reads back every column the header needs",
      read == {c.id: c for c in sample})
try:
    src.read_cards(os.path.join(SCRATCH, "secret.txt"))
    check("a file that is not a card database is refused", False)
except src.SourceError as exc:
    check("a file that is not a card database is refused, in a sentence",
          "not a card database" in str(exc) or "Could not open" in str(exc), exc)
pack = make_pack(os.path.join(SCRATCH, "a.ypk"), {100000001: b"--pre\n", 22: b"--newer two\n"},
                 {"test-update.cdb": [card(22, "Two, overridden")],
                  "test-release.cdb": [card(100000001, "Brand New")]})
pack_scripts, pack_databases = src.read_pack(pack)
check("a pack yields its scripts and its root databases, by name",
      sorted(pack_scripts) == [22, 100000001]
      and [name for name, _ in pack_databases] == ["test-release.cdb", "test-update.cdb"]
      and pack_databases[0][1][100000001].name == "Brand New")

# ------------------------------------------------------------ §6 THE RULE
print("--- §6 the official release first; the pack only for what it lacks")
official = src.official_layer({1: b"--one\n", 22: b"--two\n", 33: b"--three\n", 44: b"--no row\n"},
                              {1: card(1, "One"), 22: card(22, "Two"),
                               99: card(99, "No Script")})
pre = src.prerelease_layer(
    {22: b"--newer two\n", 100000001: b"--pre\n", 100000002: b"--pre, no row\n"},
    [("test-release.cdb", {100000001: card(100000001, "Brand New")}),
     ("test-update.cdb", {22: card(22, "Two, overridden"), 33: card(33, "Three")})])
entries, orphans = src.resolve([official, pre])
by_id = {entry.card.id: entry for entry in entries}
check("a released card is its released script beside its released details",
      by_id[22].script == b"--two\n" and by_id[22].card.name == "Two"
      and by_id[22].source_db == "cards.cdb" and by_id[22].layer == src.OFFICIAL)
check("…the pack's newer copy of the script and its overriding row are both passed over",
      b"newer" not in by_id[22].script and "overridden" not in by_id[22].card.name)
check("a pre-release card is the pack's script beside the pack's details",
      by_id[100000001].script == b"--pre\n" and by_id[100000001].source_db == "test-release.cdb"
      and by_id[100000001].layer == src.PRERELEASE)
check("a released script the official database has no row for yet falls back to the pack's row",
      by_id[33].card.name == "Three" and by_id[33].source_db == "test-update.cdb"
      and by_id[33].layer == src.OFFICIAL)
check("a script with details nowhere is an orphan, named with its layer — never an entry",
      orphans == [(src.OFFICIAL, 44), (src.PRERELEASE, 100000002)]
      and 44 not in by_id and 100000002 not in by_id, orphans)
check("details without a script are not a corpus card", 99 not in by_id)
check("entries come back by passcode", [e.card.id for e in entries] == sorted(by_id))

# -------------------------------------------------- §7 names that collide
print("--- §7 two cards never share a file")


def entry(card_id, name, layer=src.OFFICIAL, **fields):
    return src.Entry(card(card_id, name, **fields),
                     "cards.cdb" if layer == src.OFFICIAL else "test-release.cdb",
                     layer, script_of(card_id))


files, superseded = up.name_files([
    entry(10, "Plain Card"),
    entry(24925387, "Adamancipator Conductor"),
    entry(101306024, "Adamancipator conductor", src.PRERELEASE),
    entry(300, "Twin"), entry(200, "Twin", alias=300), entry(250, "TWIN"),
    entry(101, "Pre Twin", src.PRERELEASE), entry(102, "Pre Twin", src.PRERELEASE),
    entry(400, "???"), entry(500, "NUL"),
])
names = {name: e.card.id for name, e in files.items()}
check("an ordinary card is simply its name", names.get("Plain_Card.lua") == 10)
check("a pre-release card with a released card's name IS that card: the released one is kept",
      names.get("Adamancipator_Conductor.lua") == 24925387
      and [e.card.id for e in superseded] == [101306024], superseded)
check("two printings under one name: the one that is nobody's alias keeps it, "
      "then the lowest passcode; the rest carry their passcode",
      names.get("TWIN.lua") == 250 and names.get("Twin_300.lua") == 300
      and names.get("Twin_200.lua") == 200, sorted(names))
check("…compared without regard to case, as Windows compares them",
      len({name.lower() for name in names}) == len(names))
check("two pre-release cards under one name are told apart the same way",
      names.get("Pre_Twin.lua") == 101 and names.get("Pre_Twin_102.lua") == 102)
check("a name that cannot be a file carries its passcode instead",
      names.get("card_400.lua") == 400 and names.get("NUL_500.lua") == 500, sorted(names))
check("every entry is filed or accounted for", len(files) + len(superseded) == 10)
try:
    up.name_files([entry(1, "Twin"), entry(2, "Twin"), entry(3, "Twin_2")])
    check("a passcode-suffixed name landing on a third card is refused, not overwritten", False)
except up.UpdateError as exc:
    check("a passcode-suffixed name landing on a third card is refused, not overwritten",
          "Twin_2.lua" in str(exc), exc)

# ---------------------------------------------------------- §8 the update
print("--- §8 the update: every kind of change, and nothing else")


def world(name, official_scripts, official_cards, pack_scripts=None, pack_dbs=None):
    """Three source files for one state of the game."""
    base = os.path.join(SCRATCH, name)
    os.makedirs(base)
    return ["--scripts", make_zip(os.path.join(base, "script.zip"),
                                  {"script/c%d.lua" % i: d for i, d in official_scripts.items()}),
            "--cards-db", make_cdb(os.path.join(base, "cards.cdb"), official_cards),
            "--prerelease", make_pack(os.path.join(base, "pre.ypk"), pack_scripts or {},
                                      pack_dbs or {"test-release.cdb": []})]


def update(root, sources, *flags):
    out = io.StringIO()
    with contextlib.redirect_stdout(out), contextlib.redirect_stderr(out):
        code = up.main(list(sources) + ["--root", root] + list(flags))
    return code, out.getvalue()


def corpus(root):
    folder = os.path.join(root, up.CORPUS_DIR)
    if not os.path.isdir(folder):
        return {}
    found = {}
    for name in sorted(os.listdir(folder)):
        with open(os.path.join(folder, name), "rb") as handle:
            found[name] = handle.read()
    return found


repo = os.path.join(SCRATCH, "repo")
os.makedirs(os.path.join(repo, "custom_cards"))
custom = (fmt.START_LINE + "\n-- Card: House Card  (ID: 211000)\n-- Type: Monster / Effect\n--\n"
          "-- Effect Text:\n-- A custom effect.\n" + fmt.END_LINE + "\n\n--house\n").encode()
with open(os.path.join(repo, "custom_cards", "House_Card.lua"), "wb") as handle:
    handle.write(custom)

before = world(
    "before",
    {1: script_of(1), 2: script_of(2), 3: script_of(3), 4: script_of(4), 5: script_of(5), 6: script_of(6)},
    [card(1, "Stays Put"), card(2, "Old Name"), card(3, "Text Changes"), card(4, "Script Changes"),
     card(5, "Both Change"), card(6, "Scale Zero", type=0x1000021)],
    {100000007: script_of(100000007), 100000008: script_of(100000008)},
    {"test-release.cdb": [card(100000007, "Soon Released"), card(100000008, "Provisional Name")]})

code, said = update(repo, before)
check("a dry run reports and writes nothing",
      code == 0 and "dry run" in said and corpus(repo) == {}
      and not os.path.exists(os.path.join(repo, "effect_index.json")), said[-300:])
code, said = update(repo, before, "--apply")
first = corpus(repo)
check("a run that changed the corpus says what it could not refresh: the website's minings, "
      "and where their whole procedure is written down",
      "a step behind" in said and "mine_card_codes.py --verify" in said
      and "mine_api.py" in said and "mine_constants.py" in said
      and "docs/script-builder/re-mining.md" in said, said[-700:])
check("--apply writes one file per card, named after it, plus the two records",
      code == 0 and sorted(first) == sorted([
          "Stays_Put.lua", "Old_Name.lua", "Text_Changes.lua", "Script_Changes.lua",
          "Both_Change.lua", "Scale_Zero.lua", "Soon_Released.lua", "Provisional_Name.lua",
          up.LOG_FILE, up.RECORD_FILE]), sorted(first))
check("each file is the format's rendering of its card and script",
      fmt.parse(first["Stays_Put.lua"]).script == script_of(1)
      and fmt.parse(first["Soon_Released.lua"]).source_db == "test-release.cdb"
      and b"-- Pendulum Scale: L0 / R0" in first["Scale_Zero.lua"])
with open(os.path.join(repo, "effect_index.json"), encoding="utf-8") as handle:
    index = json.load(handle)
check("the effect index is rebuilt with it, custom_cards/ included",
      sorted(e["path"] for e in index) == sorted(
          ["custom_cards/House_Card.lua"]
          + ["mdpro3_scripts_named/" + n for n in first if n.endswith(".lua")]))
log = first[up.LOG_FILE].decode("utf-8").split("\n")
check("the log is one row per card by passcode, with repository-relative paths and no \\r",
      log[0] == ",".join(up.LOG_COLUMNS)
      and log[1] == "c1.lua,1,Stays Put,written,mdpro3_scripts_named/Stays_Put.lua,cards.cdb"
      and log[8] == "c100000008.lua,100000008,Provisional Name,written,"
                    "mdpro3_scripts_named/Provisional_Name.lua,test-release.cdb"
      and b"\r" not in first[up.LOG_FILE], log[:3])
record = json.loads(first[up.RECORD_FILE])
check("the sources record counts the cards per layer and names a local source by file name only",
      record["cards"] == {"official": 6, "pre-release": 2, "total": 8}
      and record["sources"]["official-scripts"] == {"local": "script.zip"}
      and SCRATCH not in first[up.RECORD_FILE].decode(), record)

code, said = update(repo, before, "--apply")
check("a second run with the same sources changes nothing — not a byte, not a stamp",
      code == 0 and corpus(repo) == first and "up to date" not in said
      and "Wrote 0 file(s) and removed 0" in said, said[-400:])
check("…and does not tell anyone the website is now behind, as the first run did",
      "a step behind" not in said)
code, said = update(repo, before)
check("…and a dry run then says the corpus is up to date", "up to date with these sources" in said)

with open(os.path.join(repo, up.CORPUS_DIR, "My_Notes.lua"), "wb") as handle:
    handle.write(b"-- a file of my own\n")
after = world(
    "after",
    {1: script_of(1), 2: script_of(2), 3: script_of(3), 4: script_of(4, "fixed"),
     5: script_of(5, "fixed"), 6: script_of(6), 7: script_of(7), 9: script_of(9), 11: script_of(11)},
    [card(1, "Stays Put"), card(2, "New Name"), card(3, "Text Changes", desc="Errata."),
     card(4, "Script Changes"), card(5, "Both Change", atk=2000), card(6, "Scale Zero", type=0x1000021),
     card(7, "Soon Released"), card(9, "Official Name"), card(11, "Brand New")],
    {100000010: script_of(100000010), 2: script_of(2, "dev copy"), 100000007: script_of(100000007)},
    {"test-release.cdb": [card(100000010, "Next Wave"), card(100000007, "Soon Released")],
     "test-update.cdb": [card(1, "Stays Put", desc="A pack override.")]})
code, said = update(repo, after, "--list")
check("the dry run names every kind of change",
      all(part in said for part in (
          "The corpus holds 8 cards; the sources make 10.",
          "New:", "Brand_New.lua  (11)", "Next_Wave.lua  (100000010)", "Official_Name.lua  (9)",
          "Released:", "Soon_Released.lua  (100000007 -> 7)",
          "Renamed:", "Old_Name.lua -> New_Name.lua",
          "Details updated:", "Text_Changes.lua", "Script updated:", "Script_Changes.lua",
          "Details and script updated:", "Both_Change.lua",
          "Removed:", "Provisional_Name.lua  (100000008)",
          "Soon Released  (100000007)", "My_Notes.lua")), said)
check("…and has still written nothing", {k: v for k, v in corpus(repo).items() if k != "My_Notes.lua"} == first)
code, said = update(repo, after, "--apply")
second = corpus(repo)
check("--apply makes the directory equal to the sources: added, renamed, removed",
      code == 0 and sorted(n for n in second if n.endswith(".lua")) == sorted([
          "Stays_Put.lua", "New_Name.lua", "Text_Changes.lua", "Script_Changes.lua",
          "Both_Change.lua", "Scale_Zero.lua", "Soon_Released.lua", "Official_Name.lua",
          "Brand_New.lua", "Next_Wave.lua", "My_Notes.lua"]), sorted(second))
check("a card nothing changed for keeps its file byte for byte, stamp and all",
      second["Stays_Put.lua"] == first["Stays_Put.lua"]
      and second["Scale_Zero.lua"] == first["Scale_Zero.lua"])
check("…even though the pack now overrides it and carries a newer script for another",
      b"pack override" not in second["Stays_Put.lua"] and b"dev copy" not in second["New_Name.lua"])
check("a released card keeps its file and takes its official passcode and database",
      fmt.parse(second["Soon_Released.lua"]).card_id == 7
      and fmt.parse(second["Soon_Released.lua"]).source_db == "cards.cdb")
check("changed cards carry the new details and script",
      b"-- Errata." in second["Text_Changes.lua"] and b"--fixed" in second["Script_Changes.lua"]
      and b"-- ATK 2000 " in second["Both_Change.lua"] and b"--fixed" in second["Both_Change.lua"])
check("a file this tool did not write is left exactly as it was",
      second["My_Notes.lua"] == b"-- a file of my own\n")
check("custom_cards/ is never touched",
      open(os.path.join(repo, "custom_cards", "House_Card.lua"), "rb").read() == custom
      and os.listdir(os.path.join(repo, "custom_cards")) == ["House_Card.lua"])
log = second[up.LOG_FILE].decode("utf-8")
check("the log follows: the new cards, and the card left out with the reason",
      "c11.lua,11,Brand New,written,mdpro3_scripts_named/Brand_New.lua,cards.cdb" in log
      and "c100000007.lua,100000007,Soon Released,%s,,test-release.cdb" % up.SKIPPED_SUPERSEDED in log
      and "Provisional" not in log, log)
with open(os.path.join(repo, "effect_index.json"), encoding="utf-8") as handle:
    paths = {e["path"] for e in json.load(handle)}
check("the effect index follows too — no path to a file that is gone",
      "mdpro3_scripts_named/New_Name.lua" in paths and "mdpro3_scripts_named/Old_Name.lua" not in paths
      and "mdpro3_scripts_named/Provisional_Name.lua" not in paths)
code, said = update(repo, after, "--apply")
check("and again a second run changes nothing", corpus(repo) == second and "Wrote 0 file(s)" in said)

print("--- §8b the refusals")
half = world("half", {1: script_of(1)}, [card(1, "Stays Put")])
code, said = update(repo, half, "--apply")
check("sources that would empty most of the corpus are refused, with nothing written",
      code == 1 and "--allow-shrink" in said and corpus(repo) == second, said[-300:])
code, said = update(repo, half, "--apply", "--allow-shrink")
check("…unless it is asked for by name", code == 0
      and sorted(n for n in corpus(repo) if n.endswith(".lua")) == ["My_Notes.lua", "Stays_Put.lua"])
clash = world("clash", {1: script_of(1), 2: script_of(2)}, [card(1, "Stays Put"), card(2, "My Notes")])
state = corpus(repo)
code, said = update(repo, clash, "--apply")
check("a card needing the name of a file this tool did not write is refused, the file unharmed",
      code == 1 and "My_Notes.lua" in said and "did not write" in said and corpus(repo) == state,
      said[-300:])
orphaned = world("orphaned", {1: script_of(1), 77: script_of(77)}, [card(1, "Stays Put")])
os.remove(os.path.join(repo, up.CORPUS_DIR, "My_Notes.lua"))
code, said = update(repo, orphaned, "--apply")
check("a script with no details is reported and logged, not filed under a made-up name",
      code == 0 and "c77.lua  (official)" in said
      and "c77.lua,77,,%s,," % up.SKIPPED_NO_DETAILS in corpus(repo)[up.LOG_FILE].decode()
      and sorted(n for n in corpus(repo) if n.endswith(".lua")) == ["Stays_Put.lua"], said[-500:])
unnamed = world("unnamed", {1: script_of(1)}, [card(1, "Stays Put", race=0x4000000)])
code, said = update(repo, unnamed)
check("a race the format has no name for is called out, with the card it was seen on",
      "race 0x4000000  (first on Stays Put, 1)" in said and "corpus_format.py" in said, said[-400:])
code, said = update(repo, ["--scripts", os.path.join(SCRATCH, "nowhere.zip"),
                           "--cards-db", clash[3], "--prerelease", clash[5]])
check("a source that is not there is a sentence, not a traceback",
      code == 1 and "does not exist" in said and "Traceback" not in said, said[-300:])
empty_cache = os.path.join(SCRATCH, "empty-cache")
code, said = update(repo, [], "--offline", "--cache", empty_cache)
check("--offline with nothing fetched yet says to fetch once",
      code == 1 and "without --offline" in said and "Traceback" not in said, said[-300:])

# ------------------------------------------------------- §9 fetching (git)
print("--- §9 fetching: straight from git's object store, only when the branch moved")


def git(folder, *arguments):
    return subprocess.run(
        ["git", "-c", "user.name=test", "-c", "user.email=test@example.invalid",
         "-c", "commit.gpgsign=false", "-c", "core.autocrlf=false"] + list(arguments),
        cwd=folder, check=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE).stdout


def make_repo(name, branch, tree):
    folder = os.path.join(SCRATCH, "upstream-" + name)
    os.makedirs(folder)
    git(folder, "init", "--quiet")
    git(folder, "symbolic-ref", "HEAD", "refs/heads/" + branch)
    git(folder, "config", "uploadpack.allowFilter", "true")
    commit(folder, tree)
    return folder


def commit(folder, tree):
    for path, data in tree.items():
        target = os.path.join(folder, path)
        os.makedirs(os.path.dirname(target), exist_ok=True)
        with open(target, "wb") as handle:
            handle.write(data)
    git(folder, "add", "-A")
    git(folder, "commit", "--quiet", "-m", "update")
    return git(folder, "rev-parse", "HEAD").decode().strip()


try:
    subprocess.run(["git", "--version"], check=True, stdout=subprocess.PIPE)
    have_git = True
except (OSError, subprocess.CalledProcessError):
    have_git = False
if not have_git:
    print("SKIP: git is not installed here")
else:
    scripts_repo = make_repo("scripts", "master", {
        "c1.lua": crlf, "c22.lua": b"--two\n", "constant.lua": b"x", "LICENSE": b"x",
        "sub/c9.lua": b"--not at the root\n"})
    if linked:
        os.symlink("constant.lua", os.path.join(scripts_repo, "c5.lua"))
        commit(scripts_repo, {})
    with open(database, "rb") as handle:
        database_bytes = handle.read()
    cards_repo = make_repo("cards", "master", {
        "locales/en-US_mdpro3/cards.cdb": database_bytes, "locales/en-US/cards.cdb": b"other"})
    with open(pack, "rb") as handle:
        pack_bytes = handle.read()
    pack_repo = make_repo("pack", "main", {"EN/ygopro-super-pre.ypk": pack_bytes,
                                           "FR/ygopro-super-pre.ypk": b"other"})
    upstreams = (
        src.OFFICIAL_SCRIPTS._replace(url="file://" + scripts_repo),
        src.OFFICIAL_CARDS._replace(url="file://" + cards_repo),
        src.PRERELEASE_PACK._replace(url="file://" + pack_repo))
    cache = os.path.join(SCRATCH, "cache")
    told = []
    record = src.fetch(cache, upstreams, told.append)
    fetched = src.read_scripts(os.path.join(cache, src.CACHE_FILES[src.OFFICIAL_SCRIPTS.key]))
    check("the scripts arrive as one zip of the root's c<id>.lua files",
          sorted(fetched) == [1, 22], sorted(fetched))
    check("…each the committed blob to the byte, CRLF included — no checkout ever touched it",
          fetched[1] == crlf and fetched[22] == b"--two\n")
    check("…and a symbolic link committed under a script's name is not one", 5 not in fetched)
    with open(os.path.join(cache, src.CACHE_FILES[src.OFFICIAL_CARDS.key]), "rb") as handle:
        check("the database is the one file asked for, exactly", handle.read() == database_bytes)
    with open(os.path.join(cache, src.CACHE_FILES[src.PRERELEASE_PACK.key]), "rb") as handle:
        check("the pack is the English one, exactly", handle.read() == pack_bytes)
    head = git(scripts_repo, "rev-parse", "HEAD").decode().strip()
    check("the record names the commit each source was read at",
          record[src.OFFICIAL_SCRIPTS.key]["commit"] == head
          and record[src.OFFICIAL_SCRIPTS.key]["branch"] == "master"
          and record[src.PRERELEASE_PACK.key]["path"] == "EN/ygopro-super-pre.ypk"
          and src.load_record(cache) == record, record[src.OFFICIAL_SCRIPTS.key])
    check("nothing but the three files and the record is left in the cache",
          sorted(os.listdir(cache)) == sorted(list(src.CACHE_FILES.values()) + [src.CACHE_RECORD]),
          os.listdir(cache))
    os.makedirs(os.path.join(cache, "clone-interrupted", "objects"))
    with open(os.path.join(cache, "cards.cdb.part"), "wb") as handle:
        handle.write(b"half a file")
    told = []
    src.fetch(cache, upstreams, told.append)
    check("what an interrupted run left in the cache is cleared away by the next",
          sorted(os.listdir(cache)) == sorted(list(src.CACHE_FILES.values()) + [src.CACHE_RECORD]),
          os.listdir(cache))
    check("a second fetch reads nothing: no branch has moved",
          len(told) == 3 and all("unchanged since last fetch" in line for line in told), told)
    moved = commit(scripts_repo, {"c333.lua": b"--three\n"})
    told = []
    record = src.fetch(cache, upstreams, told.append)
    fetched = src.read_scripts(os.path.join(cache, src.CACHE_FILES[src.OFFICIAL_SCRIPTS.key]))
    check("when one branch moves, that source alone is read again",
          sorted(fetched) == [1, 22, 333] and record[src.OFFICIAL_SCRIPTS.key]["commit"] == moved
          and sum("fetching" in line for line in told) == 1, told)
    try:
        src.fetch(cache, (src.OFFICIAL_SCRIPTS._replace(url="file://" + scripts_repo, branch="nope"),),
                  told.append)
        check("a branch that does not exist is refused", False)
    except src.SourceError as exc:
        check("a branch that does not exist is a sentence", "no branch 'nope'" in str(exc), exc)
    code, said = update(repo, [], "--offline", "--cache", cache)
    check("the update reads a fetched cache and says where each source stands",
          code == 0 and "master %s" % moved[:10] in said and "3 scripts" in said, said[:700])

    print("--- §9b the engine reference: left behind is said, never silent")
    check("with no record of the reference there is nothing to compare, and nothing is said",
          "engine reference" not in said)
    pins = os.path.join(repo, up.REFERENCE_RECORD)
    os.makedirs(os.path.dirname(pins))

    def pin(commit):
        with open(pins, "w", encoding="utf-8") as handle:
            json.dump({"sources": {"ygopro-scripts": {"commit": commit}}}, handle)

    pin(head)
    code, said = update(repo, [], "--offline", "--cache", cache)
    check("a reference copied from an older commit of the scripts' repository is called out, "
          "both commits named",
          code == 0 and "engine reference is behind" in said and head[:10] in said
          and moved[:10] in said and "reference/ygopro/README.md" in said, said[-500:])
    pin(moved)
    code, said = update(repo, [], "--offline", "--cache", cache)
    check("a reference at the scripts' own commit is not mentioned",
          code == 0 and "engine reference" not in said, said[-300:])
    pin(head)
    code, said = update(repo, world("local-again", {1: script_of(1)}, [card(1, "Stays Put")]))
    check("sources read from local files carry no commit, so no claim is made about the reference",
          code == 0 and "engine reference" not in said, said[-300:])
    with open(pins, "w", encoding="utf-8") as handle:
        handle.write("not json")
    code, said = update(repo, [], "--offline", "--cache", cache)
    check("an unreadable record is no reason to stop an update", code == 0
          and "engine reference" not in said and "Traceback" not in said, said[-300:])

# ------------------------------------------------- §10 the corpus itself
print("--- §10 every file in the real corpus is one this tool reads and would name the same")
real = os.path.join(ROOT, up.CORPUS_DIR)
existing, foreign = up.scan(real)
check("every .lua in %s/ is a corpus file" % up.CORPUS_DIR, existing and not foreign, foreign[:5])
misnamed = []
for name, parsed in existing.items():
    stem = fmt.file_stem(parsed.name)
    if name not in (stem + ".lua", fmt.numbered_stem(stem, parsed.card_id) + ".lua"):
        misnamed.append((name, parsed.name))
check("every one is named by the rule (%d files)" % len(existing), not misnamed, misnamed[:5])
ids = {}
for name, parsed in existing.items():
    ids.setdefault(parsed.card_id, []).append(name)
check("no card is in the corpus twice", not [v for v in ids.values() if len(v) > 1],
      [v for v in ids.values() if len(v) > 1][:3])
check("no two files differ only by case", len({name.lower() for name in existing}) == len(existing))

with open(os.path.join(ROOT, up.REFERENCE_RECORD), encoding="utf-8") as handle:
    engine = json.load(handle)["sources"]
with open(os.path.join(real, up.RECORD_FILE), encoding="utf-8") as handle:
    scripts_commit = json.load(handle)["sources"][src.OFFICIAL_SCRIPTS.key].get("commit")
check("the engine reference's library is the commit the released scripts are at "
      "(reference/ygopro/README.md says how to refresh it)",
      engine[up.REFERENCE_LIBRARY]["commit"] == scripts_commit,
      "%s vs %s" % (engine[up.REFERENCE_LIBRARY]["commit"][:10], str(scripts_commit)[:10]))

print("--- §10b what is derived from the corpus describes the corpus that is there")
with open(os.path.join(real, up.LOG_FILE), encoding="utf-8", newline="") as handle:
    rows = list(csv.DictReader(handle))
written = {row["output_path"]: int(row["card_id"]) for row in rows if row["status"] == up.WRITTEN}
check("the log has one row for every file, under its repository path and passcode",
      written == {"%s/%s" % (up.CORPUS_DIR, name): parsed.card_id
                  for name, parsed in existing.items()},
      "%d rows for %d files" % (len(written), len(existing)))
check("…and every row it does not call written says why",
      all(row["status"] in (up.WRITTEN, up.SKIPPED_NO_DETAILS, up.SKIPPED_SUPERSEDED)
          for row in rows))
with open(os.path.join(real, up.RECORD_FILE), encoding="utf-8") as handle:
    record = json.load(handle)
check("the sources record counts the cards that are there",
      record["cards"]["total"] == len(existing)
      and record["cards"]["total"] == sum(n for layer, n in record["cards"].items()
                                          if layer != "total"), record["cards"])
check("…and names a commit for each of the three sources",
      sorted(record["sources"]) == sorted(u.key for u in src.UPSTREAMS)
      and all(len(source.get("commit", "")) >= 40 for source in record["sources"].values()),
      record["sources"])
with open(os.path.join(ROOT, "effect_index.json"), encoding="utf-8") as handle:
    indexed = sorted(entry["path"] for entry in json.load(handle))
on_disk = sorted("%s/%s" % (folder, name) for folder in ("custom_cards", up.CORPUS_DIR)
                 for name in os.listdir(os.path.join(ROOT, folder)) if name.endswith(".lua"))
check("the effect index names every script in the corpus and custom_cards/, and no other "
      "(after editing custom_cards/ by hand: python3 tools/mine_effects.py)",
      indexed == on_disk,
      "%d indexed, %d on disk; e.g. %s" % (len(indexed), len(on_disk),
                                           sorted(set(indexed) ^ set(on_disk))[:3]))

shutil.rmtree(SCRATCH, ignore_errors=True)
print()
print("FAILURES:", failures)
sys.exit(1 if failures else 0)
