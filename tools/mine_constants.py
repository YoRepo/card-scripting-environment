#!/usr/bin/env python3
"""Mine the corpus for engine constants, grouped into families.

Produces the constant catalogs the script studio's tag widgets offer
(EFFECT_FLAG_*, LOCATION_*, CATEGORY_*, ...), each with corpus frequency so
dropdowns can rank by real-world usage.

Like mine_api.py, the miner only owns the mechanical half: if the output
file already exists, hand-authored `desc` fields (the plain-language
explanations the studio shows when a constant is tapped) are preserved
across re-runs. Only frequencies and the constant inventory are refreshed.

Usage:
  python3 tools/mine_constants.py --out ../Website-TEST/static/data/scripter/constants.json
"""
import argparse
import json
import os
import re
import sys

TOKEN = re.compile(r"\b[A-Z][A-Z0-9_]{2,}\b")

# longest-prefix-first classification
FAMILIES = [
    "EFFECT_TYPE_", "EFFECT_FLAG_", "EFFECT_COUNT_", "EFFECT_",
    "EVENT_", "CATEGORY_", "LOCATION_", "POS_", "REASON_",
    "PHASE_", "TIMINGS_", "TIMING_", "HINTMSG_", "HINT_",
    "RESETS_", "RESET_", "STATUS_", "SUMMON_INFO_", "SUMMON_TYPE_", "TYPE_",
    "RACE_", "ATTRIBUTE_", "CHAININFO_", "SEQ_",
    "ACTIVITY_", "CHINT_", "LINK_MARKER_",
]

# Per-family floor, overriding --min-freq. A family whose membership is a
# small closed enum in the engine's own constant.lua is mined down to a
# single occurrence, because the studio renders the family as a PICKER: a
# member the global floor drops is a value the widget silently fails to
# offer, and the author who needs it is the one card that uses it. CHINT_
# is six values (constant.lua:745-750) and Final Countdown is the only
# card in the corpus that reaches for CHINT_TURN.
FAMILY_FLOOR = {
    "CHINT": 1,
}

# Per-family SEED: the full membership of a closed engine enum, spelled out
# so the picker offers all of it even where the corpus names only part.
# FAMILY_FLOOR cannot reach these — it lowers the threshold on tokens the
# sweep SAW, and a member no card ever names is counted zero, so no floor
# admits it. LINK_MARKER_ is the case that forced the distinction: the eight
# arrows are a symmetric set (constant.lua:206-213) and the corpus names only
# five of them, never the three that point downward, because a card that
# cares which way it points reads Card.GetLinkedZone as a bitmask instead of
# naming arrows. A picker offering ←→↑↖↗ and not ↙↓↘ is a picker that is
# wrong about the game, so the enum is seeded from constant.lua and the
# unused members simply carry freq 0 (they sort last, after every member the
# corpus does use). Seed a family here only when constant.lua really closes
# it; anything open-ended stays corpus-driven.
FAMILY_SEED = {
    # constant.lua:206-213 — 0x001..0x100, one bit per arrow
    "LINK_MARKER": [
        "LINK_MARKER_BOTTOM_LEFT", "LINK_MARKER_BOTTOM", "LINK_MARKER_BOTTOM_RIGHT",
        "LINK_MARKER_LEFT", "LINK_MARKER_RIGHT",
        "LINK_MARKER_TOP_LEFT", "LINK_MARKER_TOP", "LINK_MARKER_TOP_RIGHT",
    ],
}


def family_of(token):
    for p in FAMILIES:
        if token.startswith(p):
            return p.rstrip("_")
    return None


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--corpus", default=os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
    ap.add_argument("--out", required=True)
    ap.add_argument("--min-freq", type=int, default=2)
    args = ap.parse_args()

    counts = {}
    for d in ("custom_cards", "mdpro3_scripts_named"):
        full = os.path.join(args.corpus, d)
        if not os.path.isdir(full):
            continue
        for fn in sorted(os.listdir(full)):
            if not fn.endswith(".lua"):
                continue
            try:
                text = open(os.path.join(full, fn), encoding="utf-8", errors="replace").read()
            except OSError:
                continue
            for line in text.split("\n"):
                code = line.split("--")[0]
                for m in TOKEN.finditer(code):
                    counts[m.group(0)] = counts.get(m.group(0), 0) + 1

    # authored desc fields from a previous run survive the re-mine
    authored = {}
    if os.path.exists(args.out):
        try:
            with open(args.out, encoding="utf-8") as fh:
                previous = json.load(fh)
            for fam_entries in previous.get("families", {}).values():
                for entry in fam_entries:
                    if entry.get("desc"):
                        authored[entry["id"]] = entry["desc"]
        except (OSError, ValueError):
            pass

    families = {}
    seeded = {fam: dict.fromkeys(members, 0)
              for fam, members in FAMILY_SEED.items()}
    for token, freq in counts.items():
        fam = family_of(token)
        if fam is None:
            continue
        if fam in seeded and token in seeded[fam]:
            seeded[fam][token] = freq
            continue
        if freq < FAMILY_FLOOR.get(fam, args.min_freq):
            continue
        entry = {"id": token, "freq": freq}
        if token in authored:
            entry["desc"] = authored[token]
        families.setdefault(fam, []).append(entry)
    for fam, members in seeded.items():
        for token, freq in members.items():
            entry = {"id": token, "freq": freq}
            if token in authored:
                entry["desc"] = authored[token]
            families.setdefault(fam, []).append(entry)
    for fam in families:
        families[fam].sort(key=lambda x: (-x["freq"], x["id"]))

    payload = {
        "format": "scripter-constants-v1",
        "note": "mined by card-scripting-environment/tools/mine_constants.py; rerun after corpus updates (authored desc fields are preserved)",
        "families": dict(sorted(families.items())),
    }
    os.makedirs(os.path.dirname(os.path.abspath(args.out)), exist_ok=True)
    with open(args.out, "w", encoding="utf-8") as fh:
        json.dump(payload, fh, indent=1, ensure_ascii=False)
        fh.write("\n")
    total = sum(len(v) for v in families.values())
    print(f"{total} constants in {len(families)} families -> {args.out}")


if __name__ == "__main__":
    sys.exit(main())
