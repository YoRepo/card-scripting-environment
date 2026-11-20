# path: tests/unit_mine_constants.py
"""Unit tests for tools/mine_constants.py — the miner behind the website's
constant catalog (Website-TEST static/data/scripter/constants.json).

What is pinned is what a RE-MINE may and may not do to a file people have
written into: frequencies and the inventory follow the corpus, and a
hand-written desc is never lost — not when its constant's use falls under
the floor, and not when the corpus stops writing it altogether (an upstream
rename does exactly that: HINGMSG_LVRANK became HINTMSG_LVRANK in every
script at once). §3 is the two cases it cannot carry a desc over: it says so,
or it stops before writing.

Run: python3 tests/unit_mine_constants.py
"""

import json
import os
import shutil
import subprocess
import sys
import tempfile

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
TOOL = os.path.join(ROOT, "tools", "mine_constants.py")
failures = 0


def check(name, ok, extra=""):
    global failures
    print(("PASS: " if ok else "FAIL: ") + name
          + ("" if ok or not extra else " — " + str(extra)[:400]))
    if not ok:
        failures += 1


corpus = tempfile.mkdtemp(prefix="mine-constants-test-")
os.makedirs(os.path.join(corpus, "mdpro3_scripts_named"))
os.makedirs(os.path.join(corpus, "custom_cards"))
os.makedirs(os.path.join(corpus, "reference", "ygopro", "ygopro-scripts"))
with open(os.path.join(corpus, "reference", "ygopro", "ygopro-scripts", "constant.lua"),
          "w", encoding="utf-8") as handle:
    handle.write("CHINT_TURN\t\t=1\nCHINT_DESC\t\t=6\nLOCATION_DECK\t=0x01\n")
out = os.path.join(corpus, "constants.json")


def write_script(name, text):
    with open(os.path.join(corpus, "mdpro3_scripts_named", name), "w", encoding="utf-8") as handle:
        handle.write(text)


def mine():
    done = subprocess.run([sys.executable, TOOL, "--corpus", corpus, "--out", out],
                          stdout=subprocess.PIPE, stderr=subprocess.STDOUT, universal_newlines=True)
    with open(out, encoding="utf-8") as handle:
        return done.stdout, json.load(handle)


def members(doc, family):
    return {entry["id"]: entry for entry in doc["families"].get(family, [])}


print("--- §1 the first mining: what the corpus writes, by family")
write_script("One.lua", "e:SetCategory(CATEGORY_DRAW+CATEGORY_TOHAND)\n"
                        "Duel.Hint(HINT_SELECTMSG,tp,HINGMSG_LVRANK) -- CATEGORY_DESTROY in a comment\n"
                        "e:SetCategory(CATEGORY_DRAW)\ne:SetHintTiming(TIMING_END_PHASE)\n")
write_script("Two.lua", "e:SetCategory(CATEGORY_TOHAND)\ne:SetHintTiming(TIMING_END_PHASE)\n"
                        "Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)\nDuel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)\n")
said, doc = mine()
check("constants land in their family with how often the corpus writes them",
      members(doc, "CATEGORY")["CATEGORY_DRAW"]["freq"] == 2
      and members(doc, "CATEGORY")["CATEGORY_TOHAND"]["freq"] == 2
      and members(doc, "HINT")["HINT_SELECTMSG"]["freq"] == 3, doc["families"].get("CATEGORY"))
check("a constant only ever named in a comment is not a use",
      "CATEGORY_DESTROY" not in members(doc, "CATEGORY"))
check("a name that matches no family prefix is not catalogued (HINGMSG_ is nobody's)",
      not any("HINGMSG_LVRANK" in members(doc, fam) for fam in doc["families"]))
check("a closed enum is seeded from the engine's constant.lua, an unused member at 0",
      members(doc, "CHINT").get("CHINT_DESC", {}).get("freq") == 0
      and "CHINT_TURN" in members(doc, "CHINT"), doc["families"].get("CHINT"))
check("…and only closed enums are: an ordinary family holds what the corpus writes",
      "LOCATION" not in doc["families"])

print("--- §2 a re-mine keeps every written desc")
for family in doc["families"].values():
    for entry in family:
        if entry["id"] in ("CATEGORY_DRAW", "CATEGORY_TOHAND", "TIMING_END_PHASE", "HINTMSG_TARGET"):
            entry["desc"] = "what %s means, written by hand" % entry["id"]
with open(out, "w", encoding="utf-8") as handle:
    json.dump(doc, handle, indent=1, ensure_ascii=False)
    handle.write("\n")
# the corpus moves: TOHAND drops to one use (under the floor of 2), END_PHASE
# vanishes altogether, DRAW grows, and a new constant appears
write_script("One.lua", "e:SetCategory(CATEGORY_DRAW)\ne:SetCategory(CATEGORY_DRAW)\n"
                        "e:SetCategory(CATEGORY_DRAW+CATEGORY_TOHAND)\n")
write_script("Two.lua", "Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)\nDuel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)\n"
                        "e:SetCategory(CATEGORY_REMOVE)\ne:SetCategory(CATEGORY_REMOVE)\n")
said, doc = mine()
category, timing = members(doc, "CATEGORY"), members(doc, "TIMING")
check("frequencies follow the corpus", category["CATEGORY_DRAW"]["freq"] == 3, category)
check("a new constant joins its family, with no desc yet",
      category.get("CATEGORY_REMOVE") == {"id": "CATEGORY_REMOVE", "freq": 2}, category.get("CATEGORY_REMOVE"))
check("a constant with a desc that fell UNDER the floor is kept, desc and honest count",
      category.get("CATEGORY_TOHAND") == {"id": "CATEGORY_TOHAND", "freq": 1,
                                          "desc": "what CATEGORY_TOHAND means, written by hand"},
      category.get("CATEGORY_TOHAND"))
check("a constant with a desc that the corpus stopped writing altogether is kept too, at 0",
      timing.get("TIMING_END_PHASE") == {"id": "TIMING_END_PHASE", "freq": 0,
                                         "desc": "what TIMING_END_PHASE means, written by hand"},
      doc["families"].get("TIMING"))
check("…and the run names what it kept for that reason",
      "kept for their desc" in said and "CATEGORY_TOHAND" in said and "TIMING_END_PHASE" in said, said)
check("a constant WITHOUT a desc under the floor is dropped as before",
      "HINT_SELECTMSG" in members(doc, "HINT") and "TIMING_DAMAGE" not in timing)
check("a family is ordered most used first", [e["id"] for e in doc["families"]["CATEGORY"]]
      == ["CATEGORY_DRAW", "CATEGORY_REMOVE", "CATEGORY_TOHAND"])
again_said, again = mine()
check("mining twice changes nothing", again == doc)

print("--- §3 what it cannot carry over, it says — or stops")
doc["families"]["RETIRED"] = [{"id": "RETIRED_THING", "freq": 4, "desc": "a family this miner no longer knows"}]
with open(out, "w", encoding="utf-8") as handle:
    json.dump(doc, handle, indent=1, ensure_ascii=False)
said, after = mine()
check("a desc whose constant belongs to no family the miner knows is named, loudly, not dropped in silence",
      "RETIRED" not in after["families"] and "WARNING" in said and "RETIRED_THING" in said, said)
with open(out, "w", encoding="utf-8") as handle:
    handle.write('{"families": {"CATEGORY": [{"id": "CATEGORY_DRAW", "desc": "cut off')
done = subprocess.run([sys.executable, TOOL, "--corpus", corpus, "--out", out],
                      stdout=subprocess.PIPE, stderr=subprocess.STDOUT, universal_newlines=True)
with open(out, encoding="utf-8") as handle:
    left = handle.read()
check("a catalog that cannot be read is not overwritten: its descs would be gone",
      done.returncode != 0 and left.endswith("cut off") and "cannot be read" in done.stdout
      and "Traceback" not in done.stdout, done.stdout)

shutil.rmtree(corpus, ignore_errors=True)
print()
print("FAILURES:", failures)
sys.exit(1 if failures else 0)
