--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:26
-- Card: 元素英雄 幽冥女郎  (ID: 33574806)
-- Type: Monster / Effect / Fusion
-- Attribute: DARK
-- Race: Warrior
-- Level 8
-- ATK 2500 | DEF 2000
-- Setcode: 12296
--
-- Effect Text:
-- 名字带有「元素英雄」的怪兽＋暗属性怪兽
-- 这张卡不用融合召唤不能特殊召唤。这张卡的攻击力上升自己墓地存在的名字带有「元素英雄」的怪兽数量×100的数值。
--[[ __CARD_HEADER_END__ ]]

--E・HERO エスクリダオ
function c33574806.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcFun2(c,aux.FilterBoolFunction(Card.IsFusionSetCard,0x3008),aux.FilterBoolFunction(Card.IsFusionAttribute,ATTRIBUTE_DARK),true)
	--spsummon condition
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e2:SetCode(EFFECT_SPSUMMON_CONDITION)
	e2:SetValue(aux.fuslimit)
	c:RegisterEffect(e2)
	--atkup
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCode(EFFECT_UPDATE_ATTACK)
	e3:SetValue(c33574806.atkup)
	c:RegisterEffect(e3)
end
c33574806.material_setcode=0x8
function c33574806.atkfilter(c)
	return c:IsSetCard(0x3008) and c:IsType(TYPE_MONSTER)
end
function c33574806.atkup(e,c)
	return Duel.GetMatchingGroupCount(c33574806.atkfilter,c:GetControler(),LOCATION_GRAVE,0,nil)*100
end
