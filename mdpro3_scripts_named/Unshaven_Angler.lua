--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:36
-- Card: 髭须鮟鱇  (ID: 92084010)
-- Type: Monster / Effect
-- Attribute: WATER
-- Race: Fish
-- Level 4
-- ATK 1500 | DEF 1600
--
-- Effect Text:
-- 作为水属性怪兽祭品召唤的场合，这只怪兽1只可以作为2只份的祭品使用。
--[[ __CARD_HEADER_END__ ]]

--ヒゲアンコウ
function c92084010.initial_effect(c)
	--double tribute
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_DOUBLE_TRIBUTE)
	e1:SetValue(c92084010.condition)
	c:RegisterEffect(e1)
end
function c92084010.condition(e,c)
	return c:IsAttribute(ATTRIBUTE_WATER)
end
