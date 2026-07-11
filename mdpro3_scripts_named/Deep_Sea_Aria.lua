--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:51
-- Source DB: cards.cdb
-- Card: Deep Sea Aria  (ID: 72060415)
-- Type: Spell
-- Scope: OCG / TCG
--
-- Effect Text:
-- Banish 1 WATER monster from your GY; add 1 Level 4 or lower Sea Serpent monster from your Deck to
-- your hand.
-- You can only activate 1 "Deep Sea Aria" per turn.
--[[ __CARD_HEADER_END__ ]]

--深海のアリア
function c72060415.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,72060415+EFFECT_COUNT_CODE_OATH)
	e1:SetCost(c72060415.cost)
	e1:SetTarget(c72060415.target)
	e1:SetOperation(c72060415.activate)
	c:RegisterEffect(e1)
end
function c72060415.costfilter(c)
	return c:IsAttribute(ATTRIBUTE_WATER) and c:IsAbleToRemoveAsCost()
end
function c72060415.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c72060415.costfilter,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,c72060415.costfilter,tp,LOCATION_GRAVE,0,1,1,nil)
	Duel.Remove(g,POS_FACEUP,REASON_COST)
end
function c72060415.filter(c)
	return c:IsLevelBelow(4) and c:IsRace(RACE_SEASERPENT) and c:IsAbleToHand()
end
function c72060415.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c72060415.filter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c72060415.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c72060415.filter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
