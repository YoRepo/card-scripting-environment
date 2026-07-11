--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:45
-- Source DB: cards.cdb
-- Card: The Trojan Horse  (ID: 38479725)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Beast
-- Level: 4
-- ATK 1600 | DEF 1200
-- Scope: OCG / TCG
--
-- Effect Text:
-- This card can be treated as 2 Tributes for the Tribute Summon of an EARTH monster.
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
