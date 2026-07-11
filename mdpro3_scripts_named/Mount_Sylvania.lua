--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:51
-- Source DB: cards.cdb
-- Card: Mount Sylvania  (ID: 70222318)
-- Type: Spell / Field
-- Setcode: 0x90
-- Scope: OCG / TCG
--
-- Effect Text:
-- You can send 1 Plant-Type monster from your hand or face-up from your side of the field to the
-- Graveyard; choose 1 "Sylvan" card from your Deck and place it on top of the Deck.
-- You can only use this effect of "Mount Sylvania" once per turn.
-- Once per turn, during your opponent's End Phase: You can excavate the top card of your Deck, and if
-- it is a Plant-Type monster, send it to the Graveyard.
-- Otherwise, place it on either the top or bottom of your Deck.
--[[ __CARD_HEADER_END__ ]]

--森羅の霊峰
function c70222318.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_FZONE)
	e2:SetCountLimit(1,70222318)
	e2:SetCost(c70222318.cost)
	e2:SetTarget(c70222318.target)
	e2:SetOperation(c70222318.operation)
	c:RegisterEffect(e2)
	--deck check
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(70222318,3))
	e3:SetCategory(CATEGORY_DECKDES)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e3:SetRange(LOCATION_FZONE)
	e3:SetCode(EVENT_PHASE+PHASE_END)
	e3:SetCountLimit(1)
	e3:SetCondition(c70222318.tgcon)
	e3:SetTarget(c70222318.tgtg)
	e3:SetOperation(c70222318.tgop)
	c:RegisterEffect(e3)
end
function c70222318.cfilter(c)
	return c:IsRace(RACE_PLANT) and (c:IsLocation(LOCATION_HAND) or c:IsFaceup()) and c:IsAbleToGraveAsCost()
end
function c70222318.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c70222318.cfilter,tp,LOCATION_HAND+LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c70222318.cfilter,tp,LOCATION_HAND+LOCATION_MZONE,0,1,1,nil)
	Duel.SendtoGrave(g,REASON_COST)
end
function c70222318.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsSetCard,tp,LOCATION_DECK,0,1,nil,0x90) end
end
function c70222318.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(70222318,0))
	local g=Duel.SelectMatchingCard(tp,Card.IsSetCard,tp,LOCATION_DECK,0,1,1,nil,0x90)
	local tc=g:GetFirst()
	if tc then
		Duel.ShuffleDeck(tp)
		Duel.MoveSequence(tc,SEQ_DECKTOP)
		Duel.ConfirmDecktop(tp,1)
	end
end
function c70222318.tgcon(e,tp,eg,ep,ev,re,r,rp)
	return tp~=Duel.GetTurnPlayer()
end
function c70222318.tgtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDiscardDeck(tp,1) end
end
function c70222318.tgop(e,tp,eg,ep,ev,re,r,rp)
	if not Duel.IsPlayerCanDiscardDeck(tp,1) then return end
	Duel.ConfirmDecktop(tp,1)
	local g=Duel.GetDecktopGroup(tp,1)
	local tc=g:GetFirst()
	if tc:IsRace(RACE_PLANT) then
		Duel.DisableShuffleCheck()
		Duel.SendtoGrave(g,REASON_EFFECT+REASON_REVEAL)
	else
		local opt=Duel.SelectOption(tp,aux.Stringid(70222318,1),aux.Stringid(70222318,2))
		if opt==1 then
			Duel.MoveSequence(tc,opt)
		end
	end
end
