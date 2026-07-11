--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:50
-- Source DB: cards.cdb
-- Card: Margin Trading  (ID: 62632427)
-- Type: Spell
-- Scope: OCG / TCG
--
-- Effect Text:
-- Your opponent can discard 1 card to negate this effect, otherwise both players look at their
-- opponent's Deck and choose 1 card, then add the card from their own Deck chosen by their opponent to
-- their hand.
-- You can only activate 1 "Margin Trading" per turn.
--[[ __CARD_HEADER_END__ ]]

--信用取引
function c62632427.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(62632427,0))
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH+CATEGORY_HANDES_OPPO)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,62632427+EFFECT_COUNT_CODE_OATH)
	e1:SetTarget(c62632427.target)
	e1:SetOperation(c62632427.activate)
	c:RegisterEffect(e1)
end
function c62632427.filter(c,p)
	return c:IsAbleToHand(p)
end
function c62632427.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c62632427.filter,tp,LOCATION_DECK,0,1,nil,tp)
		and Duel.IsExistingMatchingCard(c62632427.filter,tp,0,LOCATION_DECK,1,nil,1-tp) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,2,PLAYER_ALL,LOCATION_DECK)
end
function c62632427.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetFieldGroupCount(tp,0,LOCATION_HAND)>0 and Duel.IsChainDisablable(0)
		and Duel.SelectYesNo(1-tp,aux.Stringid(62632427,1)) then
		Duel.DiscardHand(1-tp,aux.TRUE,1,1,REASON_EFFECT+REASON_DISCARD)
		Duel.NegateEffect(0)
		return
	end
	local d1=Duel.GetFieldGroup(tp,LOCATION_DECK,0)
	local d2=Duel.GetFieldGroup(tp,0,LOCATION_DECK)
	if #d1==0 or #d2==0 then return end
	Duel.ConfirmCards(tp,d2)
	Duel.ConfirmCards(1-tp,d1)
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(62632427,2))
	local g2=Duel.SelectMatchingCard(tp,c62632427.filter,tp,0,LOCATION_DECK,1,1,nil,tp)
	Duel.Hint(HINT_SELECTMSG,1-tp,aux.Stringid(62632427,2))
	local g1=Duel.SelectMatchingCard(1-tp,c62632427.filter,tp,LOCATION_DECK,0,1,1,nil,tp)
	Duel.BreakEffect()
	Duel.SendtoHand(g2,nil,REASON_EFFECT)
	Duel.ConfirmCards(tp,g2)
	Duel.SendtoHand(g1,nil,REASON_EFFECT)
	Duel.ConfirmCards(1-tp,g1)
end
