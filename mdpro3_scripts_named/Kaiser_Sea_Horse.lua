--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:24
-- Card: 帝王海马  (ID: 17444133)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Sea Serpent
-- Level 4
-- ATK 1700 | DEF 1650
--
-- Effect Text:
-- ①：光属性怪兽上级召唤的场合，这张卡可以作为2只的数量解放。
--[[ __CARD_HEADER_END__ ]]

--カイザー・シーホース
function c17444133.initial_effect(c)
	--double tribute
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_DOUBLE_TRIBUTE)
	e1:SetValue(c17444133.condition)
	c:RegisterEffect(e1)
end
function c17444133.condition(e,c)
	return c:IsAttribute(ATTRIBUTE_LIGHT)
end
