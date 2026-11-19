# card-scripting-environment

The ground-truth corpus for Yu-Gi-Oh (mdpro3, ygopro lineage) card scripting.

## Layout

- `mdpro3_scripts_named/` — the Lua script of **every real card**, named by
  card name: 13,749 files at the 2026-11 update (13,572 released cards and
  the 177 then in pre-release; `mdpro3_scripts_named/corpus_sources.json`
  always holds the current count and the upstream commits it reflects).
  Each file opens with a structured
  header comment (`__CARD_HEADER_START__` … `__CARD_HEADER_END__`) carrying
  the card's name, ID, type line, stats, setcode, and effect text.
  **This directory is GENERATED** — by `tools/update_corpus.py`, from the
  game's own scripts and card databases — so never edit a file in it by hand:
  the next update writes it again. See "Keeping the corpus up to date" below.
- `custom_cards/` — house custom scripts (the Crimsonheart archetype and
  friends). These use the modern idiom (`local s,id,o=GetID()`, numbered
  `--(n)` effect comments, `aux.Stringid(id,n)`) and are the **house-style
  emission target** for generated scripts.
- `reference/ygopro/` — the **ygopro** engine source (MyCard lineage; NOT
  EdoPro, which diverged) — authoritative for function SIGNATURES / arity, and
  the source read for return types, optional defaults, viewpoint meaning, and
  required-non-nil params. `Website-TEST/tests/mine_reqargs.js` mines its C
  source into `reqargs.json` (the required-non-nil map behind the studio's RED
  filter-forward tier) — the sole engine-source miner, distinct from the
  corpus-script miners (`tools/mine_api.py`, `tools/mine_constants.py`).
  See its `README.md` and `Website-TEST/docs/script-builder/api-signature-integrity.md`.
- `tools/` — the corpus's own tooling: `update_corpus.py` (below), and the
  miners that read the corpus (`mine_effects.py` → `effect_index.json`, the
  index the website's Script Studio searches cards by effect with;
  `mine_api.py` and `mine_constants.py` → the studio's catalogs in
  `Website-TEST`).
- `tests/` — `python3 tests/unit_update_corpus.py` (no network, no
  dependencies).

## Keeping the corpus up to date

    python3 tools/update_corpus.py            # fetch, and report what would change
    python3 tools/update_corpus.py --apply    # ...and write it

One command, safe to repeat: without `--apply` it writes nothing. It needs
Python 3 and `git`, nothing else.

**The corpus is a function of its sources.** For every card the game has a
script for there is one file: named after the card, holding the card's
details as a header comment and then the script exactly as upstream ships
it. The tool computes that whole set and makes the directory equal to it —
new cards added, changed ones rewritten, renamed ones renamed, and files no
source has any more removed. A file whose card did not change is not
touched (its `Generated` line is the last time it did).

**Three modules, three questions** — and each answer has that one home:

- `tools/corpus_sources.py` — WHERE cards come from. Three upstream sources,
  in two layers: the **official release** (scripts:
  `github.com/mycard/ygopro-scripts` `master`; details:
  `github.com/mycard/ygopro-database`, `locales/en-US_mdpro3/cards.cdb` —
  the two files MDPro4 ships as `Data/script.zip` and
  `Data/locales/en-US/cards.cdb`) and the **pre-release pack**
  (`github.com/ElderLich/Pre-Release-Translations`,
  `EN/ygopro-super-pre.ypk` — cards announced and scripted but not yet
  released, under temporary passcodes from 100000000 up). THE RULE is one
  sentence, `resolve`: *the official release first, for everything; the pack
  only for what the official release does not have yet.* So a released card
  is its released script beside its released details, and a card that gets
  released moves layers by itself.
- `tools/corpus_format.py` — WHAT a corpus file is: every line of the header
  and the file's name. The format was recovered from the files a lost tool
  first generated, and is held to them:
  `tests/fixtures/first_generation.json` is a covering sample of real cards
  with the headers that generation wrote. Changing a rule there rewrites
  every file it touches on the next update.
- `tools/update_corpus.py` — WHAT TO DO to the directory: name the files,
  compare, write the difference; then rewrite the three things derived from
  the corpus so they never describe one that is gone:
  `mdpro3_scripts_named/card_header_log.csv` (passcode → name → file, one
  row per card), `mdpro3_scripts_named/corpus_sources.json` (the upstream
  commit each source was at — how current the corpus is), and
  `effect_index.json`.

It never touches `custom_cards/`. What it cannot refresh is what
`Website-TEST` mined from this corpus (the studio's API and constant
catalogs, the archetype-name table): those are that repository's own
re-mining steps, with their own gates, and an update here leaves them one
step behind until they are run.

`reference/ygopro/` is not refreshed by it either — it is the engine's
source, pinned separately (see its README), and may be older or newer than
the corpus.

## How this repo is used

1. **Reference-driven custom scripting**: when scripting a new custom card,
   find real cards with similar effects here, study their scripts, and model
   the new script on them. Store finished customs in `custom_cards/` with
   the standard header + numbered effect comments.
2. **Ground truth for the script builder**: the sibling repo `Website-TEST`
   contains a low-code card-script-builder spec
   (`docs/script-builder/` — start at its `README.md`). Every catalog
   entry, emission rule, and fixture in that spec must be grounded in this
   corpus. If your task is the "card per day" loop, follow
   `Website-TEST/docs/script-builder/workbench-playbook.md` (the v2 successor;
   the old `expansion-playbook.md` is archived — do not follow it, it catalogs
   effect shapes, which v2 abandoned). It includes the grep-based
   sibling-finding and frequency-test steps that run against this repo. Any
   session that authors an API signature must additionally follow
   `Website-TEST/docs/script-builder/api-signature-integrity.md` — read the
   true signature from `reference/ygopro/` (see the Layout note above) and pass
   the gate (`node tests/validate_api_sigs.js` in `Website-TEST`).

Useful corpus queries (`rg` from the repo root):

```
rg -l "SpecialSummonStep" mdpro3_scripts_named | head        # find siblings by API call
rg -l "EFFECT_CANNOT_ACTIVATE" mdpro3_scripts_named | wc -l  # frequency test
rg -B2 -A8 "function s.initial_effect" custom_cards/<X>.lua  # house-style skeleton
```
