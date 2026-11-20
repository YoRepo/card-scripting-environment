#!/usr/bin/env python3
"""What a corpus file IS — the one home of the format.

Every file in mdpro3_scripts_named/ is one real card: a generated header
comment carrying the card's details, a blank line, then the card's script
exactly as upstream ships it:

    --[[ __CARD_HEADER_START__ ]]
    -- Generated: 2026-07-12T02:17:44
    -- Source DB: cards.cdb
    -- Card: A-Assault Core  (ID: 30012506)
    -- Type: Monster / Effect / Union
    -- Attribute: LIGHT
    -- Race: Machine
    -- Level: 4
    -- ATK 1900 | DEF 200
    -- Setcode: 0x136
    -- Scope: OCG / TCG
    --
    -- Effect Text:
    -- Once per turn, you can either: Target 1 LIGHT Machine monster ...
    --[[ __CARD_HEADER_END__ ]]

    --Ａ－アサルト・コア
    function c30012506.initial_effect(c)

and is named after the card (`A-Assault_Core.lua`). This module decides both
halves — what the header says (`header_lines`, `render`) and what the file is
called (`file_stem`) — and reads a file back just far enough to tell whether
it changed (`parse`). It is pure: no file system, no network, no database.
Where cards come from is tools/corpus_sources.py; deciding what to write is
tools/update_corpus.py; tools/mine_effects.py reads the markers named here.

THE FORMAT WAS NOT DESIGNED HERE, IT WAS RECOVERED. The corpus was first
generated in 2026-07 by a tool that is not in this repository. Its rules were
worked out from its output and proved against it: fed the three inputs that
tool had (corpus_sources.py says which), under its precedence, this module
writes the same 13,531 file names and reproduces 13,342 of the files byte
for byte. The other 189 differ by two deliberate corrections and nothing
else:

  * a Pendulum monster whose scales are 0 gets its `Pendulum Scale` line.
    The old tool dropped the line for a scale of 0, which reads as "no
    scale" (28 cards — Supreme King Gate Zero, Mellow Madonna, ...).
  * bit 0x8 of a card's `ot` is "Simplified Chinese", as the game itself
    reads it (MDPro3 lights its SC icon for it; strings.conf `!system 1483`).
    The old tool printed "Illegal", EDOPro's name for a bit this lineage
    does not have — on 162 perfectly legal cards.

So a rule in here is a statement about 13,000 existing files. Change one and
every file it touches is rewritten on the next update; tests/
unit_update_corpus.py pins each rule against headers lifted from the corpus.

Website-TEST's static/js/studio_core.js `buildHeader` writes a header in the
same spirit for a card made on the site. It shares the two markers and the
`-- Effect Text:` line and nothing else, and is not generated from this.
"""
import re
import textwrap
from collections import namedtuple

# ---- the markers -----------------------------------------------------------
# A reader that only needs to find the header matches the TOKENS (the studio
# and mine_effects.py do); this module writes, and requires, the whole lines.
START_TOKEN = "__CARD_HEADER_START__"
END_TOKEN = "__CARD_HEADER_END__"
START_LINE = "--[[ %s ]]" % START_TOKEN
END_LINE = "--[[ %s ]]" % END_TOKEN
GENERATED_FIELD = "-- Generated:"
SOURCE_FIELD = "-- Source DB:"
TYPE_FIELD = "-- Type:"
EFFECT_FIELD = "-- Effect Text:"

# The width the effect text is wrapped to, not counting the "-- " in front.
TEXT_WIDTH = 100

# ---- a card ----------------------------------------------------------------
# One row of a ygopro card database (`datas` joined to `texts`), under the
# columns' own names — `defense` only because `def` is a Python keyword.
# Several columns are packed, and unpacking them is this module's business:
# `level` also holds a Pendulum monster's scales, `defense` a Link monster's
# arrows, `setcode` up to four 16-bit archetype codes.
Card = namedtuple(
    "Card", "id ot alias setcode type atk defense level race attribute name desc")

TYPE_MONSTER = 0x1
TYPE_XYZ = 0x800000
TYPE_PENDULUM = 0x1000000
TYPE_LINK = 0x4000000
STAT_UNKNOWN = -2          # how the database stores a printed "?"

# ---- the vocabularies ------------------------------------------------------
# What each bit is CALLED in a header. The words are the game's own
# (strings.conf `!system` 1010-1076 and 1481-1484, in bit order); the two
# that differ are the attribute's capitals and "Trap Monster" in the
# singular. A bit with no name here is printed as its hex value rather than
# dropped, and `unnamed_bits` lets the updater say so — a new monster Type
# is added to the game every few years, and that is how one will announce
# itself.
TYPE_NAMES = (
    (0x1, "Monster"), (0x2, "Spell"), (0x4, "Trap"),
    (0x10, "Normal"), (0x20, "Effect"), (0x40, "Fusion"), (0x80, "Ritual"),
    (0x100, "Trap Monster"), (0x200, "Spirit"), (0x400, "Union"),
    (0x800, "Gemini"), (0x1000, "Tuner"), (0x2000, "Synchro"),
    (0x4000, "Token"), (0x10000, "Quick-Play"), (0x20000, "Continuous"),
    (0x40000, "Equip"), (0x80000, "Field"), (0x100000, "Counter"),
    (0x200000, "Flip"), (0x400000, "Toon"), (0x800000, "Xyz"),
    (0x1000000, "Pendulum"), (0x2000000, "Special Summon"),
    (0x4000000, "Link"),
)
ATTRIBUTE_NAMES = tuple((1 << i, name) for i, name in enumerate((
    "EARTH", "WATER", "FIRE", "WIND", "LIGHT", "DARK", "DIVINE")))
RACE_NAMES = tuple((1 << i, name) for i, name in enumerate((
    "Warrior", "Spellcaster", "Fairy", "Fiend", "Zombie", "Machine", "Aqua",
    "Pyro", "Rock", "Winged Beast", "Plant", "Insect", "Thunder", "Dragon",
    "Beast", "Beast-Warrior", "Dinosaur", "Fish", "Sea Serpent", "Reptile",
    "Psychic", "Divine-Beast", "Creator God", "Wyrm", "Cyberse", "Illusion")))
# A Link monster's arrows, in the order they are read off the card — not in
# bit order.
LINK_ARROW_NAMES = (
    (0x40, "Top-Left"), (0x80, "Top"), (0x100, "Top-Right"),
    (0x8, "Left"), (0x20, "Right"),
    (0x1, "Bottom-Left"), (0x2, "Bottom"), (0x4, "Bottom-Right"),
)
# `ot`: where the card has been released.
SCOPE_NAMES = (
    (0x1, "OCG"), (0x2, "TCG"), (0x4, "Custom"), (0x8, "Simplified Chinese"),
)


def _named(value, table):
    """The names of the bits set in `value`: the table's in the table's
    order, then any bit the table does not know, as hex, lowest first."""
    names = [name for bit, name in table if value & bit]
    known = 0
    for bit, _ in table:
        known |= bit
    rest = value & ~known & 0xFFFFFFFFFFFFFFFF
    bit = 1
    while rest:
        if rest & bit:
            names.append(hex(bit))
            rest &= ~bit
        bit <<= 1
    return names


def _unknown(value, table):
    known = 0
    for bit, _ in table:
        known |= bit
    return value & ~known & 0xFFFFFFFFFFFFFFFF


def unnamed_bits(card):
    """Every bit of this card a header had to print as a number because no
    vocabulary above names it — as sentences-in-waiting like "race 0x4000000".
    Empty for every card the game has today."""
    found = []
    checks = [("type", card.type, TYPE_NAMES), ("scope", card.ot, SCOPE_NAMES)]
    if card.type & TYPE_MONSTER:
        checks += [("attribute", card.attribute, ATTRIBUTE_NAMES),
                   ("race", card.race, RACE_NAMES)]
        if card.type & TYPE_LINK:
            checks.append(("link arrow", card.defense, LINK_ARROW_NAMES))
    for what, value, table in checks:
        rest = _unknown(value, table)
        bit = 1
        while rest:
            if rest & bit:
                found.append("%s %s" % (what, hex(bit)))
                rest &= ~bit
            bit <<= 1
    return found


# ---- the header ------------------------------------------------------------
def one_line(text):
    """`text` as one line. A header is a block of `--` comments, one fact per
    line, and a card's name comes from a database this repository does not
    control: a line break inside one would end the comment and put the rest
    of the name into the script as code."""
    return " ".join((text or "").split())


def _stat(value):
    return "?" if value == STAT_UNKNOWN else str(value)


def setcodes(card):
    """The card's archetype codes — up to four, sixteen bits each, packed
    into one column lowest first."""
    packed = card.setcode & 0xFFFFFFFFFFFFFFFF
    codes = [(packed >> shift) & 0xFFFF for shift in (0, 16, 32, 48)]
    return [code for code in codes if code]


def text_lines(desc):
    """A card's text as header lines. The database's own line breaks are the
    card's structure — the mdpro3 database puts each effect on its own line —
    so they are kept, and each of those lines is wrapped on its own to
    TEXT_WIDTH. Hyphens are not break points ("non-Link", "face-down" stay
    whole), which is what the corpus has always done."""
    lines = []
    for paragraph in (desc or "").replace("\r\n", "\n").replace("\r", "\n").split("\n"):
        paragraph = paragraph.strip()
        if not paragraph:
            lines.append("--")
            continue
        for row in textwrap.wrap(paragraph, width=TEXT_WIDTH, break_on_hyphens=False):
            lines.append("-- " + row)
    return lines


def header_lines(card, source_db, generated):
    """The whole header, first marker to last, as a list of lines.

    `source_db` is the file name of the database the details were read from
    (`cards.cdb`, `test-release.cdb`); `generated` the moment this version of
    the file was made, as text."""
    out = [START_LINE,
           "%s %s" % (GENERATED_FIELD, one_line(generated)),
           "%s %s" % (SOURCE_FIELD, one_line(source_db)),
           "-- Card: %s  (ID: %d)" % (one_line(card.name), card.id),
           "%s %s" % (TYPE_FIELD, " / ".join(_named(card.type, TYPE_NAMES)))]
    if card.type & TYPE_MONSTER:
        if card.attribute:
            out.append("-- Attribute: " + " / ".join(_named(card.attribute, ATTRIBUTE_NAMES)))
        if card.race:
            out.append("-- Race: " + " / ".join(_named(card.race, RACE_NAMES)))
        level = card.level & 0xFF
        if card.type & TYPE_LINK:
            # A Link monster has no DEF: that column holds its arrows.
            out.append("-- Link Rating: %d" % level)
            out.append("-- Link Arrows: " + ", ".join(_named(card.defense, LINK_ARROW_NAMES)))
            out.append("-- ATK %s" % _stat(card.atk))
        else:
            out.append("-- %s: %d" % ("Rank" if card.type & TYPE_XYZ else "Level", level))
            out.append("-- ATK %s | DEF %s" % (_stat(card.atk), _stat(card.defense)))
        if card.type & TYPE_PENDULUM:
            out.append("-- Pendulum Scale: L%d / R%d"
                       % ((card.level >> 24) & 0xFF, (card.level >> 16) & 0xFF))
    codes = setcodes(card)
    if codes:
        out.append("-- Setcode: " + ", ".join(hex(code) for code in codes))
    if card.alias:
        out.append("-- Alias of: %d" % card.alias)
    if card.ot:
        out.append("-- Scope: " + " / ".join(_named(card.ot, SCOPE_NAMES)))
    out.append("--")
    out.append(EFFECT_FIELD)
    out.extend(text_lines(card.desc))
    out.append(END_LINE)
    return out


def render(card, source_db, generated, script):
    """One corpus file, as bytes: the header, a blank line, the script.

    `script` is the upstream file's bytes and goes in untouched — its line
    endings, its encoding, its last byte. (.gitattributes keeps git from
    normalising them either.)"""
    header = "\n".join(header_lines(card, source_db, generated))
    return header.encode("utf-8") + b"\n\n" + script


# ---- reading one back ------------------------------------------------------
# What the updater needs to know about a file already in the corpus. `facts`
# is the header minus its `Generated` line: two files with equal `facts` and
# equal `script` are the same file made at different times, which is how an
# update leaves an unchanged card's stamp — and the file — alone.
Parsed = namedtuple("Parsed", "card_id name source_db generated facts script")

_CARD_LINE = re.compile(r"^-- Card: (.*)  \(ID: (\d+)\)$")


def parse(content):
    """Read a corpus file's bytes back, or None when they are not a file
    this module wrote (no header, or a header it cannot follow)."""
    opening = START_LINE.encode("ascii") + b"\n"
    closing = b"\n" + END_LINE.encode("ascii") + b"\n\n"
    if not content.startswith(opening):
        return None
    end = content.find(closing)
    if end == -1:
        return None
    header = content[:end].decode("utf-8", "replace").split("\n") + [END_LINE]
    script = content[end + len(closing):]
    # The stamp is the header's second line and only that one: a card whose
    # text happens to start a line with "Generated:" keeps its text.
    generated = ""
    if len(header) > 1 and header[1].startswith(GENERATED_FIELD):
        generated = header[1][len(GENERATED_FIELD):].strip()
        del header[1]
    card_id = name = None
    source_db = ""
    for line in header:
        if line.startswith(SOURCE_FIELD) and not source_db:
            source_db = line[len(SOURCE_FIELD):].strip()
        elif card_id is None:
            match = _CARD_LINE.match(line)
            if match:
                name, card_id = match.group(1), int(match.group(2))
    if card_id is None:
        return None
    return Parsed(card_id, name, source_db, generated, tuple(header), script)


def facts_of(card, source_db):
    """What `parse(...).facts` will be for this card — the header with no
    `Generated` line."""
    lines = header_lines(card, source_db, "")
    return tuple(lines[:1] + lines[2:])


# ---- the file name ---------------------------------------------------------
# Names Windows keeps for devices; a file called one of them — with any
# extension — cannot be checked out there.
_RESERVED = frozenset(
    ["CON", "PRN", "AUX", "NUL"]
    + ["COM%d" % n for n in range(1, 10)] + ["LPT%d" % n for n in range(1, 10)])


def file_stem(name):
    """The file name a card's name becomes, without the `.lua`.

    The characters no Windows path may hold are dropped, runs of spaces
    become one underscore, and trailing dots go ("Ready for Intercepting..."
    cannot end a Windows file name). Proved on all 13,531 files the first
    generation wrote. It can come back empty or unusable for a name made of
    nothing else — `usable_stem` says, and `numbered_stem` is the way out."""
    stem = re.sub(r'[<>:"/\\|?*]', "", name or "")
    stem = re.sub(r"\s+", "_", stem.strip())
    stem = re.sub(r"[\x00-\x1f\x7f]", "", stem)
    return stem.rstrip(". ").lstrip(".")


def usable_stem(stem):
    """Whether a stem can be a file's name on every system the repository is
    checked out on."""
    return bool(stem) and stem.split(".")[0].upper() not in _RESERVED


def numbered_stem(stem, card_id):
    """The stem for a card that cannot have its plain one — because the
    plain one is unusable, or because another card already has it."""
    return "%s_%d" % (stem, card_id) if stem else "card_%d" % card_id
