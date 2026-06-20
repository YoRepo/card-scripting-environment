--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:36
-- Card: 牛头人马兽  (ID: 94905343)
-- Type: Monster / Fusion
-- Attribute: EARTH
-- Race: Beast-Warrior
-- Level 6
-- ATK 2000 | DEF 1700
--
-- Effect Text:
-- 「牛头人」＋「人马兽」
--[[ __CARD_HEADER_END__ ]]

--ミノケンタウロス
function c94905343.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCode2(c,5053103,68516705,true,true)
end
