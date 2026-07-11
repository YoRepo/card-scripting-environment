--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:50
-- Source DB: cards.cdb
-- Card: Wall Shadow  (ID: 63162310)
-- Type: Monster / Effect / Special Summon
-- Attribute: DARK
-- Race: Warrior
-- Level: 7
-- ATK 1600 | DEF 3000
-- Scope: OCG / TCG
--
-- Effect Text:
-- Cannot be Normal Summoned/Set.
-- Must first be Special Summoned with "Magical Labyrinth".
--[[ __CARD_HEADER_END__ ]]

--ウォール・シャドウ
function c63162310.initial_effect(c)
	c:EnableReviveLimit()
end
