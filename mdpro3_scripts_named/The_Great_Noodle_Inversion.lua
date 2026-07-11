--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:51
-- Source DB: cards.cdb
-- Card: The Great Noodle Inversion  (ID: 67906797)
-- Type: Trap
-- Scope: OCG / TCG
--
-- Effect Text:
-- Add the bottom card of your Deck to your hand, then take 1 card from your Deck, shuffle, and place
-- that card on the bottom of the Deck.
--[[ __CARD_HEADER_END__ ]]

--天地返し
function c67906797.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c67906797.target)
	e1:SetOperation(c67906797.operation)
	c:RegisterEffect(e1)
end
function c67906797.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)>=2
		and Duel.IsExistingMatchingCard(Card.IsAbleToHand,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c67906797.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetFieldGroup(tp,LOCATION_DECK,0)
	if g:GetCount()==0 then return end
	local tc=g:GetMinGroup(Card.GetSequence):GetFirst()
	Duel.DisableShuffleCheck()
	tc:SetStatus(STATUS_TO_HAND_WITHOUT_CONFIRM,true)
	if Duel.SendtoHand(tc,tp,REASON_EFFECT)>0 then
		Duel.ShuffleHand(tp)
		if Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)<=1 then return end
		Duel.BreakEffect()
		Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(67906797,1))
		local seg=Duel.SelectMatchingCard(tp,aux.TRUE,tp,LOCATION_DECK,0,1,1,nil)
		local sec=seg:GetFirst()
		if sec then
			Duel.ShuffleDeck(tp)
			Duel.MoveSequence(sec,SEQ_DECKBOTTOM)
		end
	end
end
