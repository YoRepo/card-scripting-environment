--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 幻兽机 追踪海龟  (ID: 76902476)
-- Type: Monster / Effect
-- Attribute: WIND
-- Race: Machine
-- Level 3
-- ATK 500 | DEF 2000
-- Setcode: 4123
--
-- Effect Text:
-- 这张卡的等级上升自己场上的「幻兽机衍生物」的等级的合计数值。只要自己场上有衍生物存在，这张卡不会被战斗以及效果破坏。此外，只要这张卡在场上表侧表示存在，1回合1次，自己场上的「幻兽机衍生物」不会被战斗
-- 破坏。
--[[ __CARD_HEADER_END__ ]]

--幻獣機タートレーサー
function c76902476.initial_effect(c)
	--level
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_UPDATE_LEVEL)
	e1:SetValue(c76902476.lvval)
	c:RegisterEffect(e1)
	--
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e2:SetCondition(aux.tkfcon)
	e2:SetValue(1)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	c:RegisterEffect(e3)
	--
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD)
	e4:SetCode(EFFECT_INDESTRUCTABLE_COUNT)
	e4:SetRange(LOCATION_MZONE)
	e4:SetTargetRange(LOCATION_MZONE,0)
	e4:SetTarget(c76902476.indtg)
	e4:SetCountLimit(1)
	e4:SetValue(c76902476.valcon)
	c:RegisterEffect(e4)
end
function c76902476.lvval(e,c)
	local tp=c:GetControler()
	return Duel.GetMatchingGroup(Card.IsCode,tp,LOCATION_MZONE,0,nil,31533705):GetSum(Card.GetLevel)
end
function c76902476.indtg(e,c)
	return c:IsCode(31533705)
end
function c76902476.valcon(e,re,r,rp)
	return bit.band(r,REASON_BATTLE)~=0
end
