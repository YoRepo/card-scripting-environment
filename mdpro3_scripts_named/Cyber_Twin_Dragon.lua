--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 电子双生龙  (ID: 74157028)
-- Type: Monster / Effect / Fusion
-- Attribute: LIGHT
-- Race: Machine
-- Level 8
-- ATK 2800 | DEF 2100
-- Setcode: 147
--
-- Effect Text:
-- 「电子龙」＋「电子龙」
-- 这张卡的融合召唤不用上记的卡不能进行。
-- ①：这张卡在同1次的战斗阶段中可以作2次攻击。
--[[ __CARD_HEADER_END__ ]]

--サイバー・ツイン・ドラゴン
function c74157028.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCodeRep(c,70095154,2,false,false)
	--extra att
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_EXTRA_ATTACK)
	e2:SetValue(1)
	c:RegisterEffect(e2)
end
c74157028.material_setcode=0x1093
