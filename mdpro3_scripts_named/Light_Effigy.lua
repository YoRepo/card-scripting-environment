--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:30
-- Card: 圣构体  (ID: 54766667)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Fairy
-- Level 4
-- ATK 1500 | DEF 0
--
-- Effect Text:
-- 光属性的通常怪兽祭品召唤的场合，这1只怪兽可以作为2只的数量的祭品。
--[[ __CARD_HEADER_END__ ]]

--ホーリーフレーム
function c54766667.initial_effect(c)
	--double tribute
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_DOUBLE_TRIBUTE)
	e1:SetValue(c54766667.condition)
	c:RegisterEffect(e1)
end
function c54766667.condition(e,c)
	return c:IsAttribute(ATTRIBUTE_LIGHT) and c:IsType(TYPE_NORMAL)
end
