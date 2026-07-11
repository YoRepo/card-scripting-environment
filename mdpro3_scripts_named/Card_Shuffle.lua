--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:42
-- Source DB: cards.cdb
-- Card: Card Shuffle  (ID: 12183332)
-- Type: Spell / Continuous
-- Scope: OCG / TCG
--
-- Effect Text:
-- Pay 300 Life Points to use this card's effect.
-- Shuffle either your or your opponent's Deck.
-- You can only use this effect during your turn, once per turn.
--[[ __CARD_HEADER_END__ ]]

--ショット・ガン・シャッフル
function c12183332.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--shuffle
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(12183332,0))
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCountLimit(1)
	e2:SetCost(c12183332.cost)
	e2:SetTarget(c12183332.target)
	e2:SetOperation(c12183332.operation)
	c:RegisterEffect(e2)
end
function c12183332.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(tp,300) end
	Duel.PayLPCost(tp,300)
end
function c12183332.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)>1 or Duel.GetFieldGroupCount(tp,0,LOCATION_DECK)>1 end
end
function c12183332.operation(e,tp,eg,ep,ev,re,r,rp)
	local opt
	local res0=Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)>1
	local res1=Duel.GetFieldGroupCount(tp,0,LOCATION_DECK)>1
	if res0 and res1 then
		opt=Duel.SelectOption(tp,aux.Stringid(12183332,1),aux.Stringid(12183332,2))
	elseif res0 then
		opt=Duel.SelectOption(tp,aux.Stringid(12183332,1))
	elseif res1 then
		opt=Duel.SelectOption(tp,aux.Stringid(12183332,2))+1
	else
		return
	end
	if opt==0 then
		Duel.ShuffleDeck(tp)
	else
		Duel.ShuffleDeck(1-tp)
	end
end
