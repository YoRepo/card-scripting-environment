--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 黑色食人鲛  (ID: 80727036)
-- Type: Monster / Fusion
-- Attribute: WATER
-- Race: Fish
-- Level 5
-- ATK 2100 | DEF 1300
--
-- Effect Text:
-- 「深海切割手」＋「杀人污泥」＋「海原的女战士」
--[[ __CARD_HEADER_END__ ]]

--黒き人食い鮫
function c80727036.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCode3(c,71746462,65623423,17968114,true,true)
end
