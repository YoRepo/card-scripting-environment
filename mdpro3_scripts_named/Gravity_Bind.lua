--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:52
-- Source DB: cards.cdb
-- Card: Gravity Bind  (ID: 85742772)
-- Type: Trap / Continuous
-- Scope: OCG / TCG
--
-- Effect Text:
-- Level 4 or higher monsters cannot attack.
--[[ __CARD_HEADER_END__ ]]

--グラヴィティ・バインド－超重力の網－
function c85742772.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--cannot attack
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_CANNOT_ATTACK)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e2:SetTarget(c85742772.atktarget)
	c:RegisterEffect(e2)
end
function c85742772.atktarget(e,c)
	return c:IsLevelAbove(4)
end
