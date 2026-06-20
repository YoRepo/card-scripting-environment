--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 腕龙  (ID: 16507828)
-- Type: Monster / Fusion
-- Attribute: WATER
-- Race: Dinosaur
-- Level 6
-- ATK 2200 | DEF 2000
--
-- Effect Text:
-- 「双头恐龙王」＋「贪尸龙」
--[[ __CARD_HEADER_END__ ]]

--ブラキオレイドス
function c16507828.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCode2(c,94119974,38289717,true,true)
end
