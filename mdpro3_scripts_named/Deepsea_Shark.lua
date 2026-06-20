--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 深海的潜鲛  (ID: 28593363)
-- Type: Monster / Fusion
-- Attribute: WATER
-- Race: Fish
-- Level 5
-- ATK 1900 | DEF 1600
--
-- Effect Text:
-- 「神鱼」＋「舌鱼」
--[[ __CARD_HEADER_END__ ]]

--深海に潜むサメ
function c28593363.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCode2(c,81386177,69572024,true,true)
end
