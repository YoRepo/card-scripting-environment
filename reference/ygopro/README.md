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

## Refreshing

**A reviewed act, not a side effect** — `tools/update_corpus.py` reports the
drift and deliberately does not fix it. The engine is what every hand-written
API doc in `Website-TEST` was checked against, so when it moves:

1. copy the files at the new commits (from git's objects, not a checkout that
   may have rewritten line endings) and update `sources.json`;
2. list what changed — `git diff` on this directory is the whole worklist: a
   new function, or an existing one whose body or parameter list moved;
3. in `Website-TEST`, re-run the two engine miners (`node tests/mine_sources.js`,
   `node tests/mine_reqargs.js`) and re-check the doc of every function the
   diff touched.

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
