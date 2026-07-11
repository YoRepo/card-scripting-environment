--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:49
-- Source DB: cards.cdb
-- Card: Black Luster Soldier  (ID: 5405694)
-- Type: Monster / Ritual
-- Attribute: EARTH
-- Race: Warrior
-- Level: 8
-- ATK 3000 | DEF 2500
-- Setcode: 0x10cf
-- Scope: OCG / TCG
--
-- Effect Text:
-- You can Ritual Summon this card with "Black Luster Ritual".
--[[ __CARD_HEADER_END__ ]]

--カオス・ソルジャー
function c5405694.initial_effect(c)
	aux.AddCodeList(c,55761792)
	c:EnableReviveLimit()
end
