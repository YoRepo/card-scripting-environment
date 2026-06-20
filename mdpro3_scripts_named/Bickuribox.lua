--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 恶魔箱  (ID: 25655502)
-- Type: Monster / Fusion
-- Attribute: DARK
-- Race: Fiend
-- Level 7
-- ATK 2300 | DEF 2000
--
-- Effect Text:
-- 「杀人小丑」＋「梦幻小丑」
--[[ __CARD_HEADER_END__ ]]

--デビル・ボックス
function c25655502.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCode2(c,93889755,13215230,true,true)
end
