--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:44
-- Source DB: cards.cdb
-- Card: Magician of Black Chaos  (ID: 30208479)
-- Type: Monster / Ritual
-- Attribute: DARK
-- Race: Spellcaster
-- Level: 8
-- ATK 2800 | DEF 2600
-- Setcode: 0xcf
-- Scope: OCG / TCG
--
-- Effect Text:
-- You can Ritual Summon this card with "Black Magic Ritual".
--[[ __CARD_HEADER_END__ ]]

--マジシャン・オブ・ブラックカオス
function c30208479.initial_effect(c)
	aux.AddCodeList(c,76792184)
	c:EnableReviveLimit()
end
