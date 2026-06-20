--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:30
-- Card: 地构体  (ID: 53461122)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Rock
-- Level 4
-- ATK 100 | DEF 2000
--
-- Effect Text:
-- 地属性的通常怪兽祭品召唤的场合，这1只怪兽可以作为2只的数量的祭品。
--[[ __CARD_HEADER_END__ ]]

--ガイアフレーム
function c53461122.initial_effect(c)
	--double tribute
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_DOUBLE_TRIBUTE)
	e1:SetValue(c53461122.condition)
	c:RegisterEffect(e1)
end
function c53461122.condition(e,c)
	return c:IsAttribute(ATTRIBUTE_EARTH) and c:IsType(TYPE_NORMAL)
end
