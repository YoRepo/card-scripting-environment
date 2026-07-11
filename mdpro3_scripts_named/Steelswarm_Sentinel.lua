--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:54
-- Source DB: cards.cdb
-- Card: Steelswarm Sentinel  (ID: 99214782)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Fiend
-- Level: 3
-- ATK 1100 | DEF 0
-- Setcode: 0x100a
-- Scope: OCG / TCG
--
-- Effect Text:
-- While this card is in face-up Attack Position, Special Summoned Level 5 or higher monsters on the
-- field cannot activate their effects.
--[[ __CARD_HEADER_END__ ]]

--インヴェルズの歩哨
function c99214782.initial_effect(c)
	--cannot trigger
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_TRIGGER)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(c99214782.condition)
	e1:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e1:SetTarget(c99214782.target)
	c:RegisterEffect(e1)
end
function c99214782.condition(e)
	return e:GetHandler():IsAttackPos()
end
function c99214782.target(e,c)
	return c:IsLevelAbove(5) and c:IsSummonType(SUMMON_TYPE_SPECIAL)
end
