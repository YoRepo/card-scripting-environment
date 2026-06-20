--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 暗黑魔龙  (ID: 11901678)
-- Type: Monster / Fusion
-- Attribute: DARK
-- Race: Dragon
-- Level 9
-- ATK 3200 | DEF 2500
-- Setcode: 69
--
-- Effect Text:
-- 「恶魔召唤」＋「真红眼黑龙」
--[[ __CARD_HEADER_END__ ]]

--ブラック・デーモンズ・ドラゴン
function c11901678.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCode2(c,70781052,74677422,true,true)
end
c11901678.material_setcode=0x3b
