# ygopro engine source — the authoritative signature ground truth

**What this is.** The Lua-facing API source of the **ygopro** engine that
mdpro3 is built upon — the authoritative definition of every scripting
function's real signature (required / optional / vararg). The mined corpus
`argc` envelope (in `Website-TEST/static/data/scripter/api.json`) is only a
*lower* bound on a function's true argument count; the true optional/vararg
structure comes from HERE. Used by the signature-integrity methodology:
`Website-TEST/docs/script-builder/api-signature-integrity.md` and the
`/audit-arity` workflow.

**Lineage matters — this is ygopro, NOT EdoPro.** mdpro3 is built on ygopro
(the Fluorohydride/MyCard lineage). **EdoPro forked off ygopro long ago and
diverged** — e.g. it renamed `aux.AddXyzProcedure` → `Xyz.AddProcedure`, which
this corpus never adopted — so EdoPro signatures do **not** match these cards.
Do not use edo9300/ygopro-core or ProjectIgnis/CardScripts as the source.

## Provenance

Every file here is an exact, unmodified copy of an upstream file at one commit,
and `sources.json` beside this README names that commit for each directory —
check any file with `git cat-file blob <commit>:<file>` in a clone of its
upstream:

| dir | upstream | branch |
|---|---|---|
| `ygopro-core/` | `github.com/mycard/ygopro-core` (MoeCube/koishi — the maintained ygopro core) | master |
| `ygopro-scripts/` | `github.com/mycard/ygopro-scripts` | master |

**The library half follows the corpus.** `ygopro-scripts/` is the same
repository as the released card scripts in `mdpro3_scripts_named/`, and must be
the same COMMIT (`mdpro3_scripts_named/corpus_sources.json`,
`official-scripts`): `utility.lua`, `procedure.lua` and `constant.lua` are what
those scripts are written against. A corpus update that moves that commit
leaves these three one step behind, and `tools/update_corpus.py` says so when
it happens. `ygopro-core/` is a separate repository, and nothing records which
of its commits a scripts commit was written for; take the one made alongside it
(the maintainers merge both from upstream in one sitting — a script that calls
a new `Card.*` function lands the same evening as the core change that defines
it).

**The pre-release layer has a library of its own, and it is not here.** This
directory is the RELEASED engine. The pre-release pack the corpus takes its
newest cards from (`tools/corpus_sources.py`) carries its own
`script/constant.lua` and `script/procedure.lua` — a development version, ahead
of master and not a superset of it: at the 2026-11 update, one constant more
(`CATEGORY_DECK_SPSUMMON`), helpers master does not have
(`aux.RegisterSynchroMaterialRequire` and the `SynchroRequire*` family behind
it) and reworked Fusion procedures. So a name that only a pre-release card's
script uses may be defined in the pack and nowhere in these files; it is not a
typo for that, and not yet part of the language either. The scripts say so
themselves — they guard what they borrow
(`if not CATEGORY_DECK_SPSUMMON then … end`,
`if aux.RegisterSynchroMaterialRequire then … end`).

## Refreshing

**A reviewed act, not a side effect** — `tools/update_corpus.py` reports the
drift and deliberately does not fix it. The engine is what every hand-written
API doc in `Website-TEST` was checked against, so when it moves:

1. copy the files at the new commits (from git's objects, not a checkout that
   may have rewritten line endings), update `sources.json`, and COMMIT — the
   next step finds the previous files by their git blob ids. From the
   repository root:

       SCRIPTS=$(python3 -c "import json; print(json.load(open('mdpro3_scripts_named/corpus_sources.json'))['sources']['official-scripts']['commit'])")
       UP=$(mktemp -d)
       git init -q $UP/ygopro-scripts && git -C $UP/ygopro-scripts fetch -q --depth 1 --filter=blob:none https://github.com/mycard/ygopro-scripts $SCRIPTS
       git init -q $UP/ygopro-core && git -C $UP/ygopro-core fetch -q --filter=blob:none https://github.com/mycard/ygopro-core master
       for f in reference/ygopro/ygopro-scripts/*; do git -C $UP/ygopro-scripts show FETCH_HEAD:$(basename $f) > $f; done
       for f in reference/ygopro/ygopro-core/*; do git -C $UP/ygopro-core show FETCH_HEAD:$(basename $f) > $f; done
       git -C $UP/ygopro-scripts log -1 --format='%H %cI' FETCH_HEAD
       git -C $UP/ygopro-core log -1 --format='%H %cI' FETCH_HEAD

   The last two lines print what goes into `sources.json` as each directory's
   `commit` and `committed`. The library is fetched at the commit the corpus
   records, never at `master` — the two can differ an hour after an update.
   The core is taken at `master`, which IS the commit made alongside when this
   is done in the same sitting as the corpus update; done later, take the core
   commit of the scripts commit's own evening instead
   (`git -C $UP/ygopro-core log --format='%h %cI %s' FETCH_HEAD`, then
   `show <that commit>:<file>` in the loop). The loops refresh the files that
   are here: a NEW upstream file that defines API (another `lib*.cpp`) is
   added by hand, and listed under "What's here";
2. list what changed — `git diff` on this directory is the whole worklist: a
   new function, or an existing one whose body or parameter list moved;
3. in `Website-TEST`, follow `docs/script-builder/re-mining.md`. Three things
   there hang on this directory: the docs' line citations (some six hundred
   "libcard.cpp:2576" are coordinates in the files you just replaced —
   `python3 tools/remap_engine_cites.py --write` renumbers them and lists the
   ones whose own line changed), the two engine miners
   (`node tests/mine_sources.js`, `node tests/mine_reqargs.js`), and the doc of
   every function the diff touched, re-read.

History: first vendored 2026-07-15, from the two repositories' master branches
as they stood on 2026-06-24 (`ygopro-core` `8513ea7`, `ygopro-scripts`
`df337be9` — not recorded at the time, identified afterwards by matching every
file byte for byte). Refreshed 2026-11-20, with the corpus update that moved
the scripts to `b83db1cc`: five new `Card.*` functions (`GetCardType`,
`GetPreviousCardTypeOnField`, `IsCardType`, `IsAllCardTypes`,
`IsPreviousCardTypeOnField`), `Card.RemoveCounter` now returning a boolean,
`aux.HasMentionedCounter` and `aux.ArsMagnaFilter`, a changed
`aux.RegisterMergedDelayedEvent_ToSingleCard_AddOperation` and `aux.covcheck`,
the three `EFFECT_*_CARD_TYPE` constants, and `HINTMSG_NUMBER` /
`HINTMSG_LVRANK` spelled correctly (the `HINGMSG_*` typos kept as deprecated
aliases).

## What's here (only the API-defining files, not the whole engine)

- **`ygopro-core/`** — the C++ that defines the built-in namespaces:
  `libcard.cpp` (`Card.*`), `libduel.cpp` (`Duel.*`), `libgroup.cpp`
  (`Group.*`), `libeffect.cpp` (`Effect.*`), `libdebug.cpp` (`Debug.*`), plus
  `scriptlib.{h,cpp}` and `interpreter.cpp` (arg-reading helpers).
- **`ygopro-scripts/`** — the Lua library: `utility.lua` + `procedure.lua`
  (the `aux.*` / `Auxiliary.*` functions, incl. the summon procedures) and
  `constant.lua` (the `LOCATION_*` / `TYPE_*` / … constants).

## How to read a signature

- **C++ (`Duel.*`/`Card.*`/…):** find the Lua name in the register table
  (`{ "IsSetCard", scriptlib::card_is_set_card }`), then read that
  `scriptlib::…` body: `check_param_count(L, N)` gives the required arg count
  (N **includes the receiver** for `Card`/`Group`/`Effect` methods — the
  studio `sig` excludes it, so subtract 1), and `lua_gettop(L)` handling / a
  trailing loop marks the **variadic** tail (→ `"..."`); an
  `if(lua_gettop(L) > k)` or `lua_get<…, DEFAULT>(L, k)` marks param k
  **optional**.
- **Lua (`aux.*`):** the `function Auxiliary.X(a,b,c,...)` line gives the
  params; an `if not c then c=… end` (or a `... `) marks c optional/variadic.
  Example: `Auxiliary.AddXyzProcedure(c,f,lv,ct,alterf,alterdesc,maxct,alterop)`
  with `if not maxct then maxct=ct end` → `AddXyzProcedure(c,f,lv,ct,alterf?,
  alterdesc?,maxct?,alterop?)` (4 required + 4 optional), which admits the
  corpus's observed max of 8.

## License / redistribution

ygopro-core and ygopro-scripts are third-party GPL-family sources, included
here as **internal reference only** (the same ground-truth posture as the card
scripts in this repo). If this repo is ever distributed publicly, comply with
the upstream licenses — or replace these vendored copies with a git submodule
pointing at the upstreams.
