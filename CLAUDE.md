# card-scripting-environment

The ground-truth corpus for Yu-Gi-Oh (mdpro3/EDOPro) card scripting.

## Layout

- `mdpro3_scripts_named/` — the Lua script of **every real card**
  (13,460 files), named by card name. Each file opens with a structured
  header comment (`__CARD_HEADER_START__` … `__CARD_HEADER_END__`) carrying
  the card's name, ID, type line, stats, setcode, and effect text.
  **Warning:** the header's Spell/Trap *subtype* line is unreliable
  (scrambled in the source data) — trust the script code, not the header,
  when determining Quick-Play vs Continuous vs Counter etc.
- `custom_cards/` — house custom scripts (the Crimsonheart archetype and
  friends). These use the modern idiom (`local s,id,o=GetID()`, numbered
  `--(n)` effect comments, `aux.Stringid(id,n)`) and are the **house-style
  emission target** for generated scripts.

## How this repo is used

1. **Reference-driven custom scripting**: when scripting a new custom card,
   find real cards with similar effects here, study their scripts, and model
   the new script on them. Store finished customs in `custom_cards/` with
   the standard header + numbered effect comments.
2. **Ground truth for the script builder**: the sibling repo `Website-TEST`
   contains a low-code card-script-builder spec
   (`docs/script-builder/` — start at its `README.md`). Every catalog
   entry, emission rule, and fixture in that spec must be grounded in this
   corpus. If your task is to make a card declarative ("card per day"
   workflow), follow `Website-TEST/docs/script-builder/expansion-playbook.md`
   — it includes the grep-based sibling-finding and frequency-test steps
   that run against this repo.

Useful corpus queries (`rg` from the repo root):

```
rg -l "SpecialSummonStep" mdpro3_scripts_named | head        # find siblings by API call
rg -l "EFFECT_CANNOT_ACTIVATE" mdpro3_scripts_named | wc -l  # frequency test
rg -B2 -A8 "function s.initial_effect" custom_cards/<X>.lua  # house-style skeleton
```
