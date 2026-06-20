--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:31
-- Card: 战场的死装束  (ID: 56413937)
-- Type: Monster / Fusion
-- Attribute: EARTH
-- Race: Warrior
-- Level 6
-- ATK 1900 | DEF 1700
--
-- Effect Text:
-- 「音女」＋「斩首的美女」
--[[ __CARD_HEADER_END__ ]]

--戦場の死装束
function c56413937.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCode2(c,38942059,16899564,true,true)
end
