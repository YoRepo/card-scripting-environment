--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:43
-- Source DB: cards.cdb
-- Card: Kaiser Sea Horse  (ID: 17444133)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Sea Serpent
-- Level: 4
-- ATK 1700 | DEF 1650
-- Scope: OCG / TCG
--
-- Effect Text:
-- This card can be treated as 2 Tributes for the Tribute Summon of a LIGHT monster.
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
