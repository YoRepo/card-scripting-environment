--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 电子终结龙  (ID: 1546123)
-- Type: Monster / Effect / Fusion
-- Attribute: LIGHT
-- Race: Machine
-- Level 10
-- ATK 4000 | DEF 2800
-- Setcode: 147
--
-- Effect Text:
-- 「电子龙」＋「电子龙」＋「电子龙」
-- 这张卡的融合召唤不用上记的卡不能进行。
-- ①：这张卡向守备表示怪兽攻击的场合，给与对方为攻击力超过那个守备力的数值的战斗伤害。
--[[ __CARD_HEADER_END__ ]]

--サイバー・エンド・ドラゴン
function c1546123.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCodeRep(c,70095154,3,false,false)
	--pierce
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_PIERCE)
	c:RegisterEffect(e2)
end
c1546123.material_setcode=0x1093
