--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:37
-- Card: 水精鳞-深渊肺鱼兵  (ID: 95466842)
-- Type: Monster / Effect
-- Attribute: WATER
-- Race: Fish
-- Level 4
-- ATK 1200 | DEF 1800
-- Setcode: 7667828
--
-- Effect Text:
-- 只要这张卡在场上表侧表示存在，对方不能选择其他的水属性怪兽作为攻击对象。此外，只要这张卡在场上表侧表示存在，自己场上的水属性怪兽的攻击力上升300。
--[[ __CARD_HEADER_END__ ]]

--水精鱗－アビスラング
function c95466842.initial_effect(c)
	--at limit
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_SELECT_BATTLE_TARGET)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(0,LOCATION_MZONE)
	e1:SetValue(c95466842.atlimit)
	c:RegisterEffect(e1)
	--atkup
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(LOCATION_MZONE,0)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetTarget(aux.TargetBoolFunction(Card.IsAttribute,ATTRIBUTE_WATER))
	e2:SetValue(300)
	c:RegisterEffect(e2)
end
function c95466842.atlimit(e,c)
	return c~=e:GetHandler() and c:IsFaceup() and c:IsAttribute(ATTRIBUTE_WATER)
end
