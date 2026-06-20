--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:37
-- Card: 风构体  (ID: 99865167)
-- Type: Monster / Effect
-- Attribute: WIND
-- Race: Winged Beast
-- Level 4
-- ATK 1800 | DEF 200
--
-- Effect Text:
-- 风属性的通常怪兽祭品召唤的场合，这1只怪兽可以作为2只的数量的祭品。
--[[ __CARD_HEADER_END__ ]]

--ウィンドフレーム
function c99865167.initial_effect(c)
	--double tribute
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_DOUBLE_TRIBUTE)
	e1:SetValue(c99865167.condition)
	c:RegisterEffect(e1)
end
function c99865167.condition(e,c)
	return c:IsAttribute(ATTRIBUTE_WIND) and c:IsType(TYPE_NORMAL)
end
