--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:45
-- Source DB: cards.cdb
-- Card: Skull Guardian  (ID: 3627449)
-- Type: Monster / Ritual
-- Attribute: LIGHT
-- Race: Warrior
-- Level: 7
-- ATK 2050 | DEF 2500
-- Setcode: 0x2052
-- Scope: OCG / TCG
--
-- Effect Text:
-- You can Ritual Summon this card with "Novox's Prayer".
--[[ __CARD_HEADER_END__ ]]

--ローガーディアン
function c3627449.initial_effect(c)
	aux.AddCodeList(c,43694075)
	c:EnableReviveLimit()
end
