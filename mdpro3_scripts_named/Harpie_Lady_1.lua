--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:36
-- Card: 鹰身女郎1  (ID: 91932350)
-- Type: Monster / Effect
-- Attribute: WIND
-- Race: Winged Beast
-- Level 4
-- ATK 1300 | DEF 1400
-- Setcode: 100
--
-- Effect Text:
-- 这张卡的卡名当作「鹰身女郎」使用。只要这张卡在场上存在，场上的风属性怪兽攻击力上升300。
--[[ __CARD_HEADER_END__ ]]

--ハーピィ・レディ1
function c91932350.initial_effect(c)
	--atkup
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTarget(aux.TargetBoolFunction(Card.IsAttribute,ATTRIBUTE_WIND))
	e1:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e1:SetValue(300)
	c:RegisterEffect(e1)
end
