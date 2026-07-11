--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:50
-- Source DB: cards.cdb
-- Card: Senri Eye  (ID: 60391791)
-- Type: Spell / Continuous
-- Scope: OCG / TCG
--
-- Effect Text:
-- Once per turn, during each of your Standby Phases, you can pay 100 Life Points to look at 1 card on
-- the top of your opponent's Deck and return it to its original position.
-- Your opponent cannot look at the card.
--[[ __CARD_HEADER_END__ ]]

--千里眼
function c60391791.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(60391791,0))
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCountLimit(1)
	e2:SetCondition(c60391791.cfcon)
	e2:SetCost(c60391791.cfcost)
	e2:SetOperation(c60391791.cfop)
	c:RegisterEffect(e2)
end
function c60391791.cfcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp and Duel.GetFieldGroupCount(tp,0,LOCATION_DECK)~=0
end
function c60391791.cfcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(tp,100) end
	Duel.PayLPCost(tp,100)
end
function c60391791.cfop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetDecktopGroup(1-tp,1)
	if g:GetCount()~=0 then
		Duel.ConfirmCards(tp,g)
	end
end
