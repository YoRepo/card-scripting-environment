--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:51
-- Source DB: cards.cdb
-- Card: Troposphere  (ID: 72144675)
-- Type: Monster / Effect
-- Attribute: WIND
-- Race: Winged Beast
-- Level: 6
-- ATK 2400 | DEF 2000
-- Scope: OCG / TCG
--
-- Effect Text:
-- If you Tribute Summon this card, all Tributes must be Winged Beast-Type.
-- This card is unaffected by Trap effects.
--[[ __CARD_HEADER_END__ ]]

--トラファスフィア
function c72144675.initial_effect(c)
	--tribute limit
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_TRIBUTE_LIMIT)
	e1:SetValue(c72144675.tlimit)
	c:RegisterEffect(e1)
	--immune
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EFFECT_IMMUNE_EFFECT)
	e2:SetValue(c72144675.efilter)
	c:RegisterEffect(e2)
end
function c72144675.tlimit(e,c)
	return not c:IsRace(RACE_WINDBEAST)
end
function c72144675.efilter(e,te)
	return te:IsActiveType(TYPE_TRAP)
end
