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

| dir | upstream | branch | fetched |
|---|---|---|---|
| `ygopro-core/` | `github.com/mycard/ygopro-core` (MoeCube/koishi — the maintained ygopro core) | master HEAD | 2026-07-15 |
| `ygopro-scripts/` | `github.com/mycard/ygopro-scripts` | master HEAD | 2026-07-15 |

Commit SHAs were not pinned at fetch (the GitHub commit API was proxy-blocked,
403). **Re-pin the SHA when you refresh these files** so the reference is
reproducible.

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
