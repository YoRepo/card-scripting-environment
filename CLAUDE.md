# card-scripting-environment

The ground-truth corpus for Yu-Gi-Oh (mdpro3, ygopro lineage) card scripting.

## Layout

- `mdpro3_scripts_named/` — the Lua script of **every real card**
  (13,531 files; 13,549 including the 18 `custom_cards/`), named by card name. Each file opens with a structured
  header comment (`__CARD_HEADER_START__` … `__CARD_HEADER_END__`) carrying
  the card's name, ID, type line, stats, setcode, and effect text.
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
