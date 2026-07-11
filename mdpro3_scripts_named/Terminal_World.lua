--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:49
-- Source DB: cards.cdb
-- Card: Terminal World  (ID: 54631834)
-- Type: Spell / Continuous
-- Scope: OCG / TCG
--
-- Effect Text:
-- Activate only during Main Phase 1.
-- While this card is on the field, both players skip their Main Phase 2.
--[[ __CARD_HEADER_END__ ]]

--端末世界
function c54631834.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c54631834.condition)
	c:RegisterEffect(e1)
	--skip
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTargetRange(1,1)
	e2:SetCode(EFFECT_SKIP_M2)
	c:RegisterEffect(e2)
end
function c54631834.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetCurrentPhase()==PHASE_MAIN1
end
