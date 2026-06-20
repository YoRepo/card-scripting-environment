--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 刃蝇  (ID: 28470714)
-- Type: Monster / Effect
-- Attribute: WIND
-- Race: Insect
-- Level 2
-- ATK 600 | DEF 700
--
-- Effect Text:
-- 只要这张卡在场上表侧表示存在，全部风属性的怪兽攻击力上升500。地属性的怪兽攻击力下降400。
--[[ __CARD_HEADER_END__ ]]

--ブレードフライ
function c28470714.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetTarget(c28470714.tg1)
	e1:SetValue(500)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetTarget(c28470714.tg2)
	e2:SetValue(-400)
	c:RegisterEffect(e2)
end
function c28470714.tg1(e,c)
	return c:IsAttribute(ATTRIBUTE_WIND)
end
function c28470714.tg2(e,c)
	return c:IsAttribute(ATTRIBUTE_EARTH)
end
