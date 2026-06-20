--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:31
-- Card: 假面英雄 刚火  (ID: 58147549)
-- Type: Monster / Effect / Fusion
-- Attribute: FIRE
-- Race: Warrior
-- Level 6
-- ATK 2200 | DEF 1800
-- Setcode: 40968
--
-- Effect Text:
-- 这张卡用「假面变化」的效果才能特殊召唤。这张卡的攻击力上升自己墓地存在的名字带有「英雄」的怪兽数量×100的数值。
--[[ __CARD_HEADER_END__ ]]

--M・HERO 剛火
function c58147549.initial_effect(c)
	c:EnableReviveLimit()
	--spsummon condition
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetValue(aux.MaskChangeLimit)
	c:RegisterEffect(e1)
	--atkup
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetValue(c58147549.atkup)
	c:RegisterEffect(e2)
end
function c58147549.atkfilter(c)
	return c:IsSetCard(0x8) and c:IsType(TYPE_MONSTER)
end
function c58147549.atkup(e,c)
	return Duel.GetMatchingGroupCount(c58147549.atkfilter,c:GetControler(),LOCATION_GRAVE,0,nil)*100
end
