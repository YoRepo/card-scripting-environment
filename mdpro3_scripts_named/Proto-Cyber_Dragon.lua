--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:44
-- Source DB: cards.cdb
-- Card: Proto-Cyber Dragon  (ID: 26439287)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Machine
-- Level: 3
-- ATK 1100 | DEF 600
-- Setcode: 0x1093
-- Scope: OCG / TCG
--
-- Effect Text:
-- This card's name becomes "Cyber Dragon" while on the field.
--[[ __CARD_HEADER_END__ ]]

--プロト・サイバー・ドラゴン
function c26439287.initial_effect(c)
	--code
	aux.EnableChangeCode(c,70095154)
end
