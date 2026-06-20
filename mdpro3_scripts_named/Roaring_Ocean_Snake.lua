--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:24
-- Card: 轰鸣的大海蛇  (ID: 19066538)
-- Type: Monster / Fusion
-- Attribute: WATER
-- Race: Aqua
-- Level 6
-- ATK 2100 | DEF 1800
--
-- Effect Text:
-- 「魔法灯」＋「兵主部」
--[[ __CARD_HEADER_END__ ]]

--轟きの大海蛇
function c19066538.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCode2(c,98049915,2118022,true,true)
end
