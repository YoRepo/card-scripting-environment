--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:43
-- Source DB: cards.cdb
-- Card: Whirlwind Prodigy  (ID: 15090429)
-- Type: Monster / Effect
-- Attribute: WIND
-- Race: Fairy
-- Level: 4
-- ATK 1500 | DEF 1600
-- Scope: OCG / TCG
--
-- Effect Text:
-- This card can be treated as 2 Tributes for the Tribute Summon of a WIND monster.
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
