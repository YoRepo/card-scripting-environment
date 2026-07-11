--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:52
-- Source DB: cards.cdb
-- Card: Grave of the Super Ancient Organism  (ID: 83266092)
-- Type: Trap / Continuous
-- Scope: OCG / TCG
--
-- Effect Text:
-- Level 6 or higher Special Summoned monsters on the field cannot declare attacks, nor can players
-- activate their effects.
--[[ __CARD_HEADER_END__ ]]

--超古代生物の墓場
function c83266092.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,0x28)
	c:RegisterEffect(e1)
	--cannot attack
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_CANNOT_ATTACK_ANNOUNCE)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e2:SetTarget(c83266092.target)
	c:RegisterEffect(e2)
	--cannot trigger
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_CANNOT_TRIGGER)
	e3:SetRange(LOCATION_SZONE)
	e3:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e3:SetTarget(c83266092.target)
	c:RegisterEffect(e3)
end
function c83266092.target(e,c)
	return c:IsLevelAbove(6) and c:IsSummonType(SUMMON_TYPE_SPECIAL)
end
