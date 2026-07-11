--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:46
-- Source DB: cards.cdb
-- Card: Double Coston  (ID: 44436472)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Zombie
-- Level: 4
-- ATK 1700 | DEF 1650
-- Scope: OCG / TCG
--
-- Effect Text:
-- This card can be treated as 2 Tributes for the Tribute Summon of a DARK monster.
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
