--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 超级流星  (ID: 67629977)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Fairy
-- Level 2
-- ATK 500 | DEF 700
--
-- Effect Text:
-- ①：场上的光属性怪兽的攻击力上升500，暗属性怪兽的攻击力下降400。
--[[ __CARD_HEADER_END__ ]]

--スーパースター
function c67629977.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetTarget(c67629977.tg1)
	e1:SetValue(500)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetTarget(c67629977.tg2)
	e2:SetValue(-400)
	c:RegisterEffect(e2)
end
function c67629977.tg1(e,c)
	return c:IsAttribute(ATTRIBUTE_LIGHT)
end
function c67629977.tg2(e,c)
	return c:IsAttribute(ATTRIBUTE_DARK)
end
