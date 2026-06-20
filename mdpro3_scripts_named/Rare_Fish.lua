--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 珍鱼  (ID: 80516007)
-- Type: Monster / Fusion
-- Attribute: WATER
-- Race: Fish
-- Level 4
-- ATK 1500 | DEF 1200
--
-- Effect Text:
-- 「融合体」＋「恍惚的人鱼」
--[[ __CARD_HEADER_END__ ]]

--レア・フィッシュ
function c80516007.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCode2(c,1641882,75376965,true,true)
end
