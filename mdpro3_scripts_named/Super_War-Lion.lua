--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:26
-- Card: 超级战狮  (ID: 33951077)
-- Type: Monster / Ritual
-- Attribute: EARTH
-- Race: Beast
-- Level 7
-- ATK 2300 | DEF 2100
--
-- Effect Text:
-- 「狮子的仪式」降临。
--[[ __CARD_HEADER_END__ ]]

--スーパー・ウォー・ライオン
function c33951077.initial_effect(c)
	aux.AddCodeList(c,54539105)
	c:EnableReviveLimit()
end
