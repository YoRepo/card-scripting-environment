--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 狩魂魔人  (ID: 72869010)
-- Type: Monster / Fusion
-- Attribute: DARK
-- Race: Fiend
-- Level 6
-- ATK 2200 | DEF 1800
--
-- Effect Text:
-- 「神灯魔人」＋「来自异次元的侵略者」
--[[ __CARD_HEADER_END__ ]]

--ソウル・ハンター
function c72869010.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCode2(c,99510761,28450915,true,true)
end
