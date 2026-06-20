--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: 双价体  (ID: 44436472)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Zombie
-- Level 4
-- ATK 1700 | DEF 1650
--
-- Effect Text:
-- ①：暗属性怪兽上级召唤的场合，这张卡可以作为2只的数量解放。
--[[ __CARD_HEADER_END__ ]]

--ダブルコストン
function c44436472.initial_effect(c)
	--double tribute
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_DOUBLE_TRIBUTE)
	e1:SetValue(c44436472.condition)
	c:RegisterEffect(e1)
end
function c44436472.condition(e,c)
	return c:IsAttribute(ATTRIBUTE_DARK)
end
