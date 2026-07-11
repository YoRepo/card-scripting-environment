--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:53
-- Source DB: cards.cdb
-- Card: Unshaven Angler  (ID: 92084010)
-- Type: Monster / Effect
-- Attribute: WATER
-- Race: Fish
-- Level: 4
-- ATK 1500 | DEF 1600
-- Scope: OCG / TCG
--
-- Effect Text:
-- This card can be treated as 2 Tributes for the Tribute Summon of a WATER monster.
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
