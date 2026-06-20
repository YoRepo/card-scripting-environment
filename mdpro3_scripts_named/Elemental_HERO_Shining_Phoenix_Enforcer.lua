--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: 元素英雄 闪光凤凰人  (ID: 88820235)
-- Type: Monster / Effect / Fusion
-- Attribute: FIRE
-- Race: Warrior
-- Level 8
-- ATK 2500 | DEF 2100
-- Setcode: 12296
--
-- Effect Text:
-- 「元素英雄 凤凰人」＋「元素英雄 电光侠」
-- 这只怪兽不能作融合召唤以外的特殊召唤。自己墓地每有1张名字带有「元素英雄」的卡，这张卡的攻击力上升300。这张卡不会被战斗破坏。
--[[ __CARD_HEADER_END__ ]]

--E・HERO シャイニング・フェニックスガイ
function c88820235.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCode2(c,41436536,20721928,true,true)
	--spsummon condition
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetValue(aux.fuslimit)
	c:RegisterEffect(e1)
	--indes
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e2:SetValue(1)
	c:RegisterEffect(e2)
	--atkup
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCode(EFFECT_UPDATE_ATTACK)
	e3:SetValue(c88820235.atkup)
	c:RegisterEffect(e3)
end
c88820235.material_setcode=0x8
function c88820235.atkup(e,c)
	return Duel.GetMatchingGroupCount(Card.IsSetCard,c:GetControler(),LOCATION_GRAVE,0,nil,0x3008)*300
end
