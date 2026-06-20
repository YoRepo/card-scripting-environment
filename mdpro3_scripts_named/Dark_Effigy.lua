--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 暗构体  (ID: 81755371)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Fiend
-- Level 4
-- ATK 1500 | DEF 0
--
-- Effect Text:
-- 暗属性的通常怪兽祭品召唤的场合，这1只怪兽可以作为2只的数量的祭品。
--[[ __CARD_HEADER_END__ ]]

--ダークフレーム
function c81755371.initial_effect(c)
	--double tribute
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_DOUBLE_TRIBUTE)
	e1:SetValue(c81755371.condition)
	c:RegisterEffect(e1)
end
function c81755371.condition(e,c)
	return c:IsAttribute(ATTRIBUTE_DARK) and c:IsType(TYPE_NORMAL)
end
