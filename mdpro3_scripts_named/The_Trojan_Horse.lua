--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 特洛伊木马  (ID: 38479725)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Beast
-- Level 4
-- ATK 1600 | DEF 1200
--
-- Effect Text:
-- 作为地属性怪兽祭品召唤的场合，这只怪兽1只可以作为2只份的祭品使用。
--[[ __CARD_HEADER_END__ ]]

--トロイホース
function c38479725.initial_effect(c)
	--double tribute
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_DOUBLE_TRIBUTE)
	e1:SetValue(c38479725.condition)
	c:RegisterEffect(e1)
end
function c38479725.condition(e,c)
	return c:IsAttribute(ATTRIBUTE_EARTH)
end
