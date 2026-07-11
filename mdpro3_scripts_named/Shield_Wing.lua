--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:44
-- Source DB: cards.cdb
-- Card: Shield Wing  (ID: 28859794)
-- Type: Monster / Effect
-- Attribute: WIND
-- Race: Winged Beast
-- Level: 2
-- ATK 0 | DEF 900
-- Scope: OCG / TCG
--
-- Effect Text:
-- Twice per turn, this card cannot be destroyed by battle.
--[[ __CARD_HEADER_END__ ]]

--シールド・ウィング
function c28859794.initial_effect(c)
	--battle indes
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_INDESTRUCTABLE_COUNT)
	e1:SetCountLimit(2)
	e1:SetValue(c28859794.valcon)
	c:RegisterEffect(e1)
end
function c28859794.valcon(e,re,r,rp)
	return bit.band(r,REASON_BATTLE)~=0
end
