--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:26
-- Card: 不死战士  (ID: 31339260)
-- Type: Monster / Fusion
-- Attribute: DARK
-- Race: Zombie
-- Level 3
-- ATK 1200 | DEF 900
--
-- Effect Text:
-- 「白骨」＋「格斗战士 阿提米特」
--[[ __CARD_HEADER_END__ ]]

--アンデット・ウォーリアー
function c31339260.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCode2(c,32274490,55550921,true,true)
end
