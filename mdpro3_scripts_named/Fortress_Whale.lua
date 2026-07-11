--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:50
-- Source DB: cards.cdb
-- Card: Fortress Whale  (ID: 62337487)
-- Type: Monster / Ritual
-- Attribute: WATER
-- Race: Fish
-- Level: 7
-- ATK 2350 | DEF 2150
-- Scope: OCG / TCG
--
-- Effect Text:
-- You can Ritual Summon this card with "Fortress Whale's Oath".
--[[ __CARD_HEADER_END__ ]]

--要塞クジラ
function c62337487.initial_effect(c)
	aux.AddCodeList(c,77454922)
	c:EnableReviveLimit()
end
