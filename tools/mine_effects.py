#!/usr/bin/env python3
"""Mine the corpus for a searchable card-effect index.

Every script in mdpro3_scripts_named/ and custom_cards/ opens with a
generated header comment that already carries the card's printed **effect
text** (the `-- Effect Text:` block between `__CARD_HEADER_START__` and
`__CARD_HEADER_END__`). This tool lifts that text out of every header into a
single flat index the website's Script Studio fetches once to power its
"search cards by effect" mode:

    [ {"path": "mdpro3_scripts_named/Ash_Blossom_....lua",
       "name": "Ash Blossom & Joyous Spring",
       "effect": "When a card or effect is activated ..."}, ... ]

No .cdb is needed — the effect text is derived entirely from the script
headers (which were themselves generated from cards.cdb upstream). Re-run
after corpus updates:

    python3 tools/mine_effects.py --out effect_index.json
"""
import argparse
import glob
import json
import os
import sys

DIRS = ("mdpro3_scripts_named", "custom_cards")
EFFECT_MARKER = "-- Effect Text:"
HEADER_END = "__CARD_HEADER_END__"


def extract_effect(path):
    """The printed effect text from a script's header comment, with the
    `-- ` comment prefix stripped and the original line breaks kept."""
    try:
        text = open(path, encoding="utf-8", errors="replace").read()
    except OSError:
        return ""
    out = []
    inside = False
    for line in text.split("\n"):
        stripped = line.strip()
        if not inside:
            if stripped.startswith(EFFECT_MARKER):
                inside = True
            continue
        if HEADER_END in line:
            break
        # drop the leading comment marker ("-- foo" -> "foo"); keep the rest
        body = line.lstrip()
        if body.startswith("--"):
            body = body[2:]
            if body.startswith(" "):
                body = body[1:]
        out.append(body)
    return "\n".join(out).strip()


def mine(corpus_root):
    entries = []
    for d in DIRS:
        full = os.path.join(corpus_root, d)
        if not os.path.isdir(full):
            continue
        for path in sorted(glob.glob(os.path.join(full, "*.lua"))):
            rel = os.path.relpath(path, corpus_root).replace(os.sep, "/")
            name = os.path.basename(path)[:-4].replace("_", " ")
            entries.append({"path": rel, "name": name,
                            "effect": extract_effect(path)})
    return entries


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--corpus",
                    default=os.path.dirname(os.path.dirname(os.path.abspath(__file__))),
                    help="corpus repo root (default: this repo)")
    ap.add_argument("--out", default="effect_index.json",
                    help="index path to write (default: effect_index.json at the repo root)")
    args = ap.parse_args()

    entries = mine(args.corpus)
    out = args.out if os.path.isabs(args.out) else os.path.join(args.corpus, args.out)
    with open(out, "w", encoding="utf-8") as fh:
        # compact: this file is fetched over the wire by the website
        json.dump(entries, fh, ensure_ascii=False, separators=(",", ":"))
        fh.write("\n")
    with_effect = sum(1 for e in entries if e["effect"])
    print(f"{len(entries)} cards ({with_effect} with effect text) -> {out}")


if __name__ == "__main__":
    sys.exit(main())
