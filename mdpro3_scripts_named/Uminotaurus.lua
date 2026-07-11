--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:44
-- Source DB: cards.cdb
-- Card: Uminotaurus  (ID: 30464153)
-- Type: Monster / Effect
-- Attribute: WATER
-- Race: Aqua
-- Level: 4
-- ATK 1700 | DEF 1000
-- Scope: OCG / TCG
--
-- Effect Text:
-- If a Fish, Sea Serpent, or Aqua-Type monster you control attacks a Defense Position monster, inflict
-- piercing battle damage to your opponent.
--[[ __CARD_HEADER_END__ ]]

--ウミノタウルス
function c30464153.initial_effect(c)
	--pierce
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_PIERCE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(LOCATION_MZONE,0)
	e1:SetTarget(c30464153.target)
	c:RegisterEffect(e1)
end
function c30464153.target(e,c)
	return c:IsRace(RACE_FISH+RACE_SEASERPENT+RACE_AQUA)
end
