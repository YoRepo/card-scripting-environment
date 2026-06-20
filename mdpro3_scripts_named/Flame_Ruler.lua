--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 火焰支配者  (ID: 41089128)
-- Type: Monster / Effect
-- Attribute: FIRE
-- Race: Pyro
-- Level 4
-- ATK 1500 | DEF 1600
--
-- Effect Text:
-- 祭品召唤炎属性怪兽的场合，这只怪兽1只作为2只份的祭品使用。
--[[ __CARD_HEADER_END__ ]]

--炎を支配する者
function c41089128.initial_effect(c)
	--double tribute
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_DOUBLE_TRIBUTE)
	e1:SetValue(c41089128.condition)
	c:RegisterEffect(e1)
end
function c41089128.condition(e,c)
	return c:IsAttribute(ATTRIBUTE_FIRE)
end
