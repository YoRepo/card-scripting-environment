--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:53
-- Source DB: cards.cdb
-- Card: Charge of the Light Brigade  (ID: 94886282)
-- Type: Spell
-- Scope: OCG / TCG
--
-- Effect Text:
-- Send the top 3 cards of your Deck to the GY; add 1 Level 4 or lower "Lightsworn" monster from your
-- Deck to your hand.
--[[ __CARD_HEADER_END__ ]]

--光の援軍
function c94886282.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c94886282.cost)
	e1:SetTarget(c94886282.target)
	e1:SetOperation(c94886282.activate)
	c:RegisterEffect(e1)
end
function c94886282.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDiscardDeckAsCost(tp,3) end
	Duel.DiscardDeck(tp,3,REASON_COST)
end
function c94886282.filter(c)
	return c:IsSetCard(0x38) and c:IsLevelBelow(4) and c:IsAbleToHand()
end
function c94886282.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c94886282.filter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c94886282.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c94886282.filter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
