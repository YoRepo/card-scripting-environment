--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:36
-- Card: 帝王龙  (ID: 94566432)
-- Type: Monster / Fusion
-- Attribute: LIGHT
-- Race: Dragon
-- Level 7
-- ATK 2300 | DEF 2000
--
-- Effect Text:
-- 「守城的翼龙」＋「妖精龙」
--[[ __CARD_HEADER_END__ ]]

--カイザー・ドラゴン
function c94566432.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCode2(c,87796900,20315854,true,true)
end
