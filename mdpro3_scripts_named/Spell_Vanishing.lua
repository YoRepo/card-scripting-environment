--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:44
-- Source DB: cards.cdb
-- Card: Spell Vanishing  (ID: 29735721)
-- Type: Trap / Counter
-- Scope: OCG / TCG
--
-- Effect Text:
-- Discard 2 cards from your hand.
-- Negate the activation of a Spell Card and destroy it.
-- Also, look at your opponent's hand and Deck and if you find any Spell Cards of the same name as the
-- destroyed Spell Card, send all of them to the Graveyard.
--[[ __CARD_HEADER_END__ ]]

--呪術抹消
function c29735721.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_NEGATE+CATEGORY_DESTROY+CATEGORY_DECKDES)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_CHAINING)
	e1:SetCondition(c29735721.condition)
	e1:SetCost(c29735721.cost)
	e1:SetTarget(c29735721.target)
	e1:SetOperation(c29735721.activate)
	c:RegisterEffect(e1)
end
function c29735721.condition(e,tp,eg,ep,ev,re,r,rp)
	return re:IsActiveType(TYPE_SPELL) and re:IsHasType(EFFECT_TYPE_ACTIVATE) and Duel.IsChainNegatable(ev)
end
function c29735721.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if Duel.IsPlayerAffectedByEffect(tp,EFFECT_DISCARD_COST_CHANGE) then return true end
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsDiscardable,tp,LOCATION_HAND,0,2,e:GetHandler()) end
	Duel.DiscardHand(tp,Card.IsDiscardable,2,2,REASON_COST+REASON_DISCARD)
end
function c29735721.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
	if re:GetHandler():IsDestructable() and re:GetHandler():IsRelateToEffect(re) then
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,1,0,0)
	end
end
function c29735721.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.NegateActivation(ev) and re:GetHandler():IsRelateToEffect(re) then
		Duel.Destroy(eg,REASON_EFFECT)
	end
	Duel.BreakEffect()
	local g=Duel.GetFieldGroup(tp,0,LOCATION_HAND+LOCATION_DECK)
	Duel.ConfirmCards(tp,g)
	local sg=g:Filter(Card.IsCode,nil,re:GetHandler():GetCode())
	Duel.SendtoGrave(sg,REASON_EFFECT)
	Duel.ShuffleHand(1-tp)
	Duel.ShuffleDeck(1-tp)
end
