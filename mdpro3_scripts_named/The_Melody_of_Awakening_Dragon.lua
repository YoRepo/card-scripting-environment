--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:47
-- Source DB: cards.cdb
-- Card: The Melody of Awakening Dragon  (ID: 48800175)
-- Type: Spell
-- Scope: OCG / TCG
--
-- Effect Text:
-- Discard 1 card; add up to 2 Dragon monsters with 3000 or more ATK and 2500 or less DEF from your
-- Deck to your hand.
--[[ __CARD_HEADER_END__ ]]

--ドラゴン・目覚めの旋律
function c48800175.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c48800175.cost)
	e1:SetTarget(c48800175.target)
	e1:SetOperation(c48800175.activate)
	c:RegisterEffect(e1)
end
function c48800175.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsDiscardable,tp,LOCATION_HAND,0,1,e:GetHandler()) end
	Duel.DiscardHand(tp,Card.IsDiscardable,1,1,REASON_COST+REASON_DISCARD)
end
function c48800175.filter(c)
	return c:IsRace(RACE_DRAGON) and c:IsAttackAbove(3000) and c:IsDefenseBelow(2500) and c:IsAbleToHand()
end
function c48800175.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c48800175.filter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c48800175.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c48800175.filter,tp,LOCATION_DECK,0,1,2,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
