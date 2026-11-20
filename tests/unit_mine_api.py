# path: tests/unit_mine_api.py
"""Unit tests for tools/mine_api.py — the miner behind the mined half of the
website's API catalog (Website-TEST static/data/scripter/api.json).

§1 is why the file exists: HOW MANY ARGUMENTS A CALL PASSES. The website's
signature gate (Website-TEST tests/validate_api_sigs.js) holds every
hand-written signature to the [min, max] argument counts mined here, so a
miscount is not a rounding error — it is a false accusation against a correct
doc, answered until now by a written exception per function. The counter
used to follow parentheses only; a comma inside a table argument counted as
a new argument. Each line below is a shape the real corpus writes.

§2 runs the whole miner over a few lines and pins what the catalog's readers
rely on: which namespace a call lands in, a method's receiver not counting
as an argument, a function passed by name counted as a pointer use, and that
the envelope is the counter's.

§3 is the file it writes INTO. Half of api.json is hand-written (`doc`), and
a re-mine may refresh the mined half only: with --merge every doc comes back
byte for byte, a documented function the corpus stopped calling is kept, and
the two ways to lose the written half — forgetting --merge, and merging into
a file that cannot be read — are refusals that leave the file as it was.

Run: python3 tests/unit_mine_api.py
"""

import json
import os
import shutil
import subprocess
import sys
import tempfile

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
sys.path.insert(0, os.path.join(ROOT, "tools"))

import mine_api                                              # noqa: E402

failures = 0


def check(name, ok, extra=""):
    global failures
    print(("PASS: " if ok else "FAIL: ") + name
          + ("" if ok or not extra else " — " + str(extra)[:300]))
    if not ok:
        failures += 1


def count(call):
    """count_args for the first '(' of `call`."""
    return mine_api.count_args(call, call.index("("))


# ------------------------------------------------------------ §1 the count
print("--- §1 only a comma at the call's own level separates two arguments")
CASES = [
    ("f()", 0, "no arguments"),
    ("f( )", 0, "white space is not an argument"),
    ("f(a)", 1, "one"),
    ("f(a,b,c)", 3, "three"),
    ("f(g(a,b),c)", 2, "a nested call's commas are its own"),
    ("f(function(a,b) return a end,c)", 2, "…and an inline function's parameters"),
    # the corpus's own lines, the ones the gate carried exceptions for
    ("aux.AddFusionProcCodeFunRep(c,89631139,{89631139,s.mfilter},2,2,true,true)", 7,
     "a table argument is one argument (Neo Blue-Eyes Hyper Ultimate Dragon)"),
    ("aux.RegisterMergedDelayedEvent_ToSingleCard(c,id,{EVENT_TO_GRAVE,EVENT_REMOVE})", 3,
     "…whatever it holds"),
    ("aux.CreateChecks(Card.IsRace,{RACE_DRAGON,RACE_WARRIOR,RACE_FIEND,RACE_ZOMBIE,RACE_MACHINE})", 2,
     "…and however long it is"),
    ("aux.SelectFromOptions(tp,{b1,aux.Stringid(id,1)},{b2,aux.Stringid(id,2)})", 3,
     "several tables, each with a call inside"),
    ("f({g(x,y),z},w)", 2, "a call inside a table inside the call"),
    ("f({a,{b,c}},d)", 2, "a table inside a table"),
    ("f(t[1],t[2])", 2, "an index is not a table of arguments"),
    ("f(t[g(a,b)],c)", 2, "…nor is what it is indexed by"),
    ('f("a,b",c)', 2, "a comma inside a string is text"),
    ("f('a,b')", 1, "…in either kind of quote"),
    ('f("say \\"hi, there\\"",c)', 2, "…past an escaped quote"),
    ("f([[a,b]],c)", 2, "…and inside a long string"),
    ("f(a,", None, "a call that does not close on its line is not counted at all"),
    ("f(a,{b,", None, "…wherever it breaks off"),
    ("f(table.unpack(t))", 1, "what cannot be seen: a list spread at run time is one argument here"),
]
for call, want, why in CASES:
    got = count(call)
    check("%s -> %s  (%s)" % (call if len(call) < 60 else call[:57] + "…", want, why),
          got == want, got)
check("the count starts at the parenthesis it is given, not the line's first",
      mine_api.count_args("x=g(a,b) and f(c,{d,e})", "x=g(a,b) and f(c,{d,e})".index("f(") + 1) == 2)

# ------------------------------------------------------------ §2 the miner
print("--- §2 the miner, over a few real shapes")
corpus = tempfile.mkdtemp(prefix="mine-api-test-")
os.makedirs(os.path.join(corpus, "mdpro3_scripts_named"))
os.makedirs(os.path.join(corpus, "custom_cards"))
SCRIPT = """--a card
function s.initial_effect(c)
	aux.AddFusionProcCodeFunRep(c,89631139,{89631139,s.mfilter},2,2,true,true)
	local e1=Effect.CreateEffect(c)
	e1:SetOperation(s.op)
	ea:SetOperation(s.op)
	c:RegisterEffect(e1)
end
function s.op(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(Card.IsFaceup,tp,LOCATION_MZONE,0,nil)
	local sg=g:Filter(Card.IsAbleToGrave,nil)
	Group.Merge(sg,g)
	sg:Merge(g)
	if g:GetFirst():IsFaceup() then Duel.SendtoGrave(sg,REASON_EFFECT) end -- Duel.Draw(tp,1,REASON_EFFECT)
end
"""
for folder, name in (("mdpro3_scripts_named", "Real_Card.lua"), ("custom_cards", "House_Card.lua")):
    with open(os.path.join(corpus, folder, name), "w", encoding="utf-8") as handle:
        handle.write(SCRIPT)
with open(os.path.join(corpus, "mdpro3_scripts_named", "notes.txt"), "w", encoding="utf-8") as handle:
    handle.write("Duel.Ignored(1,2,3)")
mined = mine_api.mine(corpus)


def entry(key):
    return mined.get(key) or {}


check("a namespaced call is filed under its namespace, counted once per script",
      entry("Duel.SendtoGrave").get("freq") == 2 and entry("Duel.GetMatchingGroup").get("freq") == 2)
check("the envelope is the counter's: the table argument does not widen it",
      (entry("aux.AddFusionProcCodeFunRep").get("argc_min"),
       entry("aux.AddFusionProcCodeFunRep").get("argc_max")) == (7, 7),
      entry("aux.AddFusionProcCodeFunRep"))
check("a method's receiver is not one of its arguments, in colon form or in dot form",
      (entry("Group.Merge").get("argc_min"), entry("Group.Merge").get("argc_max")) == (1, 1),
      entry("Group.Merge"))
check("a function passed by name is a pointer use, with no arguments to count",
      entry("Card.IsFaceup").get("ptr") == 2 and entry("Card.IsAbleToGrave").get("ptr") == 2)
check("a method on a receiver whose name says what it is lands in that namespace",
      entry("Effect.SetOperation").get("freq") == 2 and entry("Card.RegisterEffect").get("freq") == 2)
check("…and on a receiver whose name does not, in obj — never guessed",
      entry("obj.SetOperation").get("freq") == 2)
check("a method on another call's result is attributed to the one namespace that owns the name",
      entry("Card.IsFaceup").get("freq") == 4, entry("Card.IsFaceup").get("freq"))
check("a commented-out call is not a call", "Duel.Draw" not in mined)
check("only .lua files are read", "Duel.Ignored" not in mined)
check("examples name the card, house customs first",
      [e["card"] for e in entry("Duel.SendtoGrave").get("examples", [])] == ["House_Card", "Real_Card"],
      entry("Duel.SendtoGrave").get("examples"))

# ------------------------------------------------- §3 the file it writes into
print("--- §3 a re-mine refreshes the mined half and never loses the written one")
TOOL = os.path.join(ROOT, "tools", "mine_api.py")
out = os.path.join(corpus, "api.json")


def run(*flags):
    done = subprocess.run([sys.executable, TOOL, "--corpus", corpus, "--out", out, "--min-freq", "1"]
                          + list(flags), stdout=subprocess.PIPE, stderr=subprocess.STDOUT,
                          universal_newlines=True)
    return done.returncode, done.stdout


def catalog():
    with open(out, encoding="utf-8") as handle:
        return json.load(handle)


def by_id(document):
    return {f["id"]: f for f in document["functions"]}


code, said = run()
check("with no file there yet, the catalog is written from the corpus alone",
      code == 0 and "Duel.SendtoGrave" in by_id(catalog()), said)
document = catalog()
WRITTEN = {"sig": [{"name": "targets", "type": "card|group"}], "ret": "int",
           "desc": "Sends cards to the Graveyard — “written by hand”, é included."}
by_id(document)["Duel.SendtoGrave"]["doc"] = WRITTEN
document["functions"].append({"id": "Duel.NoLongerCalled", "ns": "Duel", "name": "NoLongerCalled",
                              "freq": 9, "argc": [1, 1], "examples": [],
                              "doc": {"sig": [], "desc": "A function the corpus used to call."}})
with open(out, "w", encoding="utf-8") as handle:
    json.dump(document, handle, indent=1, ensure_ascii=False)
    handle.write("\n")
with open(out, "rb") as handle:
    before = handle.read()

code, said = run()
with open(out, "rb") as handle:
    untouched = handle.read() == before
check("without --merge, a catalog that holds hand-written docs is not overwritten",
      code != 0 and untouched, said)
check("…and the refusal says how many docs were at stake, and what to add",
      "2 hand-written docs" in said and "--merge" in said and "Traceback" not in said, said)

with open(os.path.join(corpus, "mdpro3_scripts_named", "Third_Card.lua"), "w", encoding="utf-8") as handle:
    handle.write("function s.op(e,tp)\n\tDuel.SendtoGrave(g,REASON_EFFECT)\nend\n")
code, said = run("--merge")
merged = by_id(catalog())
check("with --merge the mined half follows the corpus", code == 0
      and merged["Duel.SendtoGrave"]["freq"] == 3, merged.get("Duel.SendtoGrave"))
check("…and a hand-written doc comes back exactly as it was written",
      merged["Duel.SendtoGrave"].get("doc") == WRITTEN, merged["Duel.SendtoGrave"].get("doc"))
check("a documented function the corpus no longer calls is kept, at 0 uses, with its doc",
      merged.get("Duel.NoLongerCalled", {}).get("freq") == 0
      and merged["Duel.NoLongerCalled"].get("doc", {}).get("desc") == "A function the corpus used to call.",
      merged.get("Duel.NoLongerCalled"))
check("the catalog is ordered most used first, then by id",
      [f["id"] for f in catalog()["functions"]]
      == [f["id"] for f in sorted(catalog()["functions"], key=lambda f: (-f["freq"], f["id"]))])
with open(out, "rb") as handle:
    first = handle.read()
run("--merge")
with open(out, "rb") as handle:
    check("merging twice changes nothing", handle.read() == first)

with open(out, "w", encoding="utf-8") as handle:
    handle.write('{"functions": [{"id": "Duel.SendtoGrave", "doc": {"desc": "cut off')
for flags in ((), ("--merge",)):
    code, said = run(*flags)
    with open(out, encoding="utf-8") as handle:
        left = handle.read()
    check("a catalog that cannot be read is not overwritten %s"
          % ("with --merge" if flags else "without --merge"),
          code != 0 and left.endswith("cut off") and "cannot be read" in said
          and "Traceback" not in said, said)

shutil.rmtree(corpus, ignore_errors=True)
print()
print("FAILURES:", failures)
sys.exit(1 if failures else 0)
