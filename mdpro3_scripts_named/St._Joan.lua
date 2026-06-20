--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:24
-- Card: 圣女 贞德  (ID: 21175632)
-- Type: Monster / Fusion
-- Attribute: LIGHT
-- Race: Fairy
-- Level 7
-- ATK 2800 | DEF 2000
--
-- Effect Text:
-- 「大慈大悲的修女」＋「堕天使 玛丽」
--[[ __CARD_HEADER_END__ ]]

--聖女ジャンヌ
function c21175632.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCode2(c,84080938,57579381,true,true)
end
