--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: 流星黑龙  (ID: 90660762)
-- Type: Monster / Fusion
-- Attribute: FIRE
-- Race: Dragon
-- Level 8
-- ATK 3500 | DEF 2000
--
-- Effect Text:
-- 「真红眼黑龙」＋「流星之龙」
--[[ __CARD_HEADER_END__ ]]

--メテオ・ブラック・ドラゴン
function c90660762.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCode2(c,74677422,64271667,true,true)
end
c90660762.material_setcode=0x3b
