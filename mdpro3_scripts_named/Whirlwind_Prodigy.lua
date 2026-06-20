--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 暴风小僧  (ID: 15090429)
-- Type: Monster / Effect
-- Attribute: WIND
-- Race: Fairy
-- Level 4
-- ATK 1500 | DEF 1600
--
-- Effect Text:
-- 祭品召唤风属性怪兽的场合，这只怪兽1只作为2只份的祭品使用。
--[[ __CARD_HEADER_END__ ]]

--暴風小僧
function c15090429.initial_effect(c)
	--double tribute
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_DOUBLE_TRIBUTE)
	e1:SetValue(c15090429.condition)
	c:RegisterEffect(e1)
end
function c15090429.condition(e,c)
	return c:IsAttribute(ATTRIBUTE_WIND)
end
