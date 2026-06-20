--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:37
-- Card: 元素女武神  (ID: 97623219)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Fairy
-- Level 4
-- ATK 1500 | DEF 1200
--
-- Effect Text:
-- 这只怪兽在场上有特定的属性的怪兽存在的场合，得到以下的效果。
-- ●炎属性：这张卡攻击力上升500。
-- ●水属性：这张卡的控制权不能变更。
--[[ __CARD_HEADER_END__ ]]

--エレメント・ヴァルキリー
function c97623219.initial_effect(c)
	--atk
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetValue(500)
	e1:SetCondition(c97623219.atkcon)
	c:RegisterEffect(e1)
	--control
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EFFECT_CANNOT_CHANGE_CONTROL)
	e2:SetCondition(c97623219.ctlcon)
	c:RegisterEffect(e2)
end
function c97623219.filter(c,att)
	return c:IsFaceup() and c:IsAttribute(att)
end
function c97623219.atkcon(e)
	return Duel.IsExistingMatchingCard(c97623219.filter,0,LOCATION_MZONE,LOCATION_MZONE,1,nil,ATTRIBUTE_FIRE)
end
function c97623219.ctlcon(e)
	return Duel.IsExistingMatchingCard(c97623219.filter,0,LOCATION_MZONE,LOCATION_MZONE,1,nil,ATTRIBUTE_WATER)
end
