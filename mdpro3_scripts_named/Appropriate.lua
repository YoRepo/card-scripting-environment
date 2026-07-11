--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:47
-- Source DB: cards.cdb
-- Card: Appropriate  (ID: 48539234)
-- Type: Trap / Continuous
-- Scope: OCG / TCG
--
-- Effect Text:
-- Activate only when your opponent draws a card(s) outside of either Draw Phase.
-- After that, each time your opponent draws a card(s) outside of either Draw Phase, immediately draw 2
-- cards.
--[[ __CARD_HEADER_END__ ]]

--便乗
function c48539234.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_DRAW)
	e1:SetCondition(c48539234.condition)
	c:RegisterEffect(e1)
	--draw
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetProperty(EFFECT_FLAG_DELAY)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCode(EVENT_DRAW)
	e2:SetCondition(c48539234.condition)
	e2:SetOperation(c48539234.operation)
	c:RegisterEffect(e2)
end
function c48539234.condition(e,tp,eg,ep,ev,re,r,rp)
	return ep~=tp and Duel.GetCurrentPhase()~=PHASE_DRAW
end
function c48539234.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_CARD,0,48539234)
	Duel.Draw(tp,2,REASON_EFFECT)
end
