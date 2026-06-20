--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:26
-- Card: 尖刺龙  (ID: 33691040)
-- Type: Monster / Fusion
-- Attribute: EARTH
-- Race: Dinosaur
-- Level 5
-- ATK 1900 | DEF 1500
--
-- Effect Text:
-- 「虎纹龙」＋「火焰毒蛇」
--[[ __CARD_HEADER_END__ ]]

--プラグティカル
function c33691040.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCode2(c,42348802,2830619,true,true)
end
