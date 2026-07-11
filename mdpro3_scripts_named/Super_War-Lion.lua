--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:45
-- Source DB: cards.cdb
-- Card: Super War-Lion  (ID: 33951077)
-- Type: Monster / Ritual
-- Attribute: EARTH
-- Race: Beast
-- Level: 7
-- ATK 2300 | DEF 2100
-- Scope: OCG / TCG
--
-- Effect Text:
-- You can Ritual Summon this card with "War-Lion Ritual".
--[[ __CARD_HEADER_END__ ]]

--スーパー・ウォー・ライオン
function c33951077.initial_effect(c)
	aux.AddCodeList(c,54539105)
	c:EnableReviveLimit()
end
