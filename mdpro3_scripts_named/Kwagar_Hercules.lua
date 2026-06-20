--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:37
-- Card: 锹甲独角仙  (ID: 95144193)
-- Type: Monster / Fusion
-- Attribute: EARTH
-- Race: Insect
-- Level 6
-- ATK 1900 | DEF 1700
--
-- Effect Text:
-- 「锹甲阿尔法」＋「大力独角仙」
--[[ __CARD_HEADER_END__ ]]

--クワガー・ヘラクレス
function c95144193.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCode2(c,60802233,52584282,true,true)
end
