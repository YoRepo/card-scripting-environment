--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:29
-- Card: 猎手猫头鹰  (ID: 51962254)
-- Type: Monster / Effect
-- Attribute: WIND
-- Race: Winged Beast
-- Level 4
-- ATK 1000 | DEF 900
--
-- Effect Text:
-- 自己场上表侧表示存在的风属性怪兽每有1只，这张卡的攻击力上升500。此外，只要自己场上有其他的风属性怪兽表侧表示存在，对方不能选择这张卡作为攻击对象。
--[[ __CARD_HEADER_END__ ]]

--ハンター・アウル
function c51962254.initial_effect(c)
	--cannot be attacked
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_CANNOT_BE_BATTLE_TARGET)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(c51962254.atcon)
	e1:SetValue(aux.imval1)
	c:RegisterEffect(e1)
	--atkup
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetRange(LOCATION_MZONE)
	e2:SetValue(c51962254.upval)
	c:RegisterEffect(e2)
end
function c51962254.cfilter(c)
	return c:IsFaceup() and c:IsAttribute(ATTRIBUTE_WIND)
end
function c51962254.atcon(e)
	return Duel.IsExistingMatchingCard(c51962254.cfilter,e:GetHandlerPlayer(),LOCATION_MZONE,0,1,e:GetHandler())
end
function c51962254.upval(e,c)
	return Duel.GetMatchingGroupCount(c51962254.upfilter,c:GetControler(),LOCATION_MZONE,0,nil)*500
end
function c51962254.upfilter(c)
	return c:IsFaceup() and c:IsAttribute(ATTRIBUTE_WIND)
end
