#!/usr/bin/env python3
"""Mine the corpus for the scripting API inventory.

Scans every .lua in mdpro3_scripts_named/ and custom_cards/ and produces the
*mined* half of the workbench API catalog (Website-TEST
static/data/scripter/api.json): for each function the corpus uses — its
namespace, call frequency, observed argument-count range, and up to three
real usage examples (card + line).

Authored fields (`doc`: signature, parameter docs, description, tags) are
NEVER produced or touched here — when --merge points at an existing
api.json, its doc fields are preserved and only the mined data is
refreshed. Run this after corpus updates.

Usage:
  python3 tools/mine_api.py --out ../Website-TEST/static/data/scripter/api.json --merge
"""
import argparse
import json
import os
import re
import sys

STATIC_NS = re.compile(r"\b(Duel|aux|Auxiliary|bit|Effect|Group|Card)\.([A-Za-z_][A-Za-z0-9_]*)")
METHOD = re.compile(r"\b([A-Za-z_][A-Za-z0-9_]*)\s*:\s*([A-Za-z_][A-Za-z0-9_]*)\s*\(")

# Receiver-name heuristics for classifying method namespaces. Authored docs
# can always override; unclassified methods land in "obj".
CARD_RECV = re.compile(r"^(c|tc|mc|sc|pc|fc|bc|rc|xc|hc|lc|wc|chkc|a|d|target)\d*$")
GROUP_RECV = re.compile(r"^(g|sg|mg|dg|rg|hg|eg|exg|og|bg|cg|tg|fg|gg)\d*$")
EFFECT_RECV = re.compile(r"^(e|te|re|ce|se|oe|pe|ge|ae|be|de|fe)\d*$")

CALL_OPEN = re.compile(r"\(")


def count_args(line, open_idx):
    """Rough top-level argument count for the call whose '(' is at open_idx."""
    depth = 0
    args = 0
    seen_any = False
    for ch in line[open_idx:]:
        if ch == "(":
            depth += 1
            if depth == 1:
                continue
        elif ch == ")":
            depth -= 1
            if depth == 0:
                return args + 1 if seen_any else 0
        if depth >= 1:
            if not ch.isspace():
                seen_any = True
            if ch == "," and depth == 1:
                args += 1
    return None  # call spans lines; unknown


def classify_method(recv):
    if CARD_RECV.match(recv):
        return "Card"
    if GROUP_RECV.match(recv):
        return "Group"
    if EFFECT_RECV.match(recv):
        return "Effect"
    return "obj"


def mine(corpus_root):
    functions = {}

    def touch(ns, name, card, line, argc):
        key = ns + "." + name
        f = functions.setdefault(key, {
            "ns": ns, "name": name, "freq": 0,
            "argc_min": None, "argc_max": None, "examples": []
        })
        f["freq"] += 1
        if argc is not None:
            f["argc_min"] = argc if f["argc_min"] is None else min(f["argc_min"], argc)
            f["argc_max"] = argc if f["argc_max"] is None else max(f["argc_max"], argc)
        if len(f["examples"]) < 3:
            snippet = line.strip()
            if len(snippet) <= 120 and all(e["card"] != card for e in f["examples"]):
                f["examples"].append({"card": card, "line": snippet})

    dirs = [("custom_cards", True), ("mdpro3_scripts_named", False)]
    for d, _ in dirs:
        full = os.path.join(corpus_root, d)
        if not os.path.isdir(full):
            continue
        for fn in sorted(os.listdir(full)):
            if not fn.endswith(".lua"):
                continue
            card = fn[:-4]
            try:
                text = open(os.path.join(full, fn), encoding="utf-8", errors="replace").read()
            except OSError:
                continue
            for line in text.split("\n"):
                stripped = line.split("--")[0]
                for m in STATIC_NS.finditer(stripped):
                    ns, name = m.group(1), m.group(2)
                    if ns == "Auxiliary":
                        ns = "aux"
                    after = stripped[m.end():m.end() + 1]
                    argc = count_args(stripped, m.end()) if after == "(" else None
                    touch(ns, name, card, line, argc)
                for m in METHOD.finditer(stripped):
                    recv, name = m.group(1), m.group(2)
                    if recv in ("Duel", "aux", "Auxiliary", "bit", "string", "table", "math"):
                        continue
                    ns = classify_method(recv)
                    argc = count_args(stripped, m.end() - 1)
                    touch(ns, name, card, line, argc)
    return functions


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--corpus", default=os.path.dirname(os.path.dirname(os.path.abspath(__file__))),
                    help="corpus repo root (default: this repo)")
    ap.add_argument("--out", required=True, help="api.json path to write")
    ap.add_argument("--merge", action="store_true",
                    help="preserve authored doc fields from the existing --out file")
    ap.add_argument("--min-freq", type=int, default=3,
                    help="drop mined-only functions used fewer than N times (authored ones always kept)")
    args = ap.parse_args()

    mined = mine(args.corpus)

    docs = {}
    meta = {}
    if args.merge and os.path.exists(args.out):
        old = json.load(open(args.out, encoding="utf-8"))
        meta = {k: v for k, v in old.items() if k != "functions"}
        for f in old.get("functions", []):
            if f.get("doc"):
                docs[f["id"]] = f["doc"]

    out_functions = []
    for key, f in mined.items():
        doc = docs.pop(key, None)
        if f["freq"] < args.min_freq and not doc:
            continue
        entry = {
            "id": key, "ns": f["ns"], "name": f["name"],
            "freq": f["freq"],
            "argc": [f["argc_min"], f["argc_max"]],
            "examples": f["examples"],
        }
        if doc:
            entry["doc"] = doc
        out_functions.append(entry)
    # authored entries whose function vanished from the corpus stay (docs are precious)
    for key, doc in docs.items():
        ns, name = key.split(".", 1)
        out_functions.append({"id": key, "ns": ns, "name": name, "freq": 0,
                              "argc": [None, None], "examples": [], "doc": doc})

    out_functions.sort(key=lambda f: (-f["freq"], f["id"]))
    payload = {
        "format": meta.get("format", "scripter-api-v1"),
        "note": "mined by card-scripting-environment/tools/mine_api.py; doc fields are hand-authored and preserved across runs",
        "functions": out_functions,
    }
    os.makedirs(os.path.dirname(os.path.abspath(args.out)), exist_ok=True)
    with open(args.out, "w", encoding="utf-8") as fh:
        json.dump(payload, fh, indent=1, ensure_ascii=False)
        fh.write("\n")
    documented = sum(1 for f in out_functions if f.get("doc"))
    print(f"{len(out_functions)} functions ({documented} documented) -> {args.out}")


if __name__ == "__main__":
    sys.exit(main())
