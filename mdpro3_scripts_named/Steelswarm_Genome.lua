--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:50
-- Source DB: cards.cdb
-- Card: Steelswarm Genome  (ID: 62729173)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Fiend
-- Level: 2
-- ATK 1000 | DEF 0
-- Setcode: 0x100a
-- Scope: OCG / TCG
--
-- Effect Text:
-- This card can be treated as 2 Tributes for the Tribute Summon of a "Steelswarm" monster.
--[[ __CARD_HEADER_END__ ]]

--インヴェルズ万能態
function c62729173.initial_effect(c)
	--double tribute
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_DOUBLE_TRIBUTE)
	e1:SetValue(c62729173.condition)
	c:RegisterEffect(e1)
end
function c62729173.condition(e,c)
	return c:IsSetCard(0x100a)
end
