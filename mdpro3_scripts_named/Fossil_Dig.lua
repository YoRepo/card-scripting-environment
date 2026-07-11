--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:47
-- Source DB: cards.cdb
-- Card: Fossil Dig  (ID: 47325505)
-- Type: Spell
-- Setcode: 0x149
-- Scope: OCG / TCG
--
-- Effect Text:
-- Add 1 Level 6 or lower Dinosaur monster from your Deck to your hand.
--[[ __CARD_HEADER_END__ ]]

--化石調査
function c47325505.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c47325505.target)
	e1:SetOperation(c47325505.activate)
	c:RegisterEffect(e1)
end
function c47325505.filter(c)
	return c:IsLevelBelow(6) and c:IsRace(RACE_DINOSAUR) and c:IsAbleToHand()
end
function c47325505.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c47325505.filter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c47325505.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c47325505.filter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
