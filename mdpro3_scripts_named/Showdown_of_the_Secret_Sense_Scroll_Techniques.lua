--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:53
-- Source DB: cards.cdb
-- Card: Showdown of the Secret Sense Scroll Techniques  (ID: 92080692)
-- Type: Trap / Counter
-- Scope: OCG / TCG
--
-- Effect Text:
-- When your opponent activates a Spell/Trap Card, or monster effect, with the same name as a card in
-- their GY: Negate the activation, and if you do, destroy that card.
--[[ __CARD_HEADER_END__ ]]

--見切りの極意
function c92080692.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_NEGATE+CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_CHAINING)
	e1:SetCondition(c92080692.condition)
	e1:SetTarget(c92080692.target)
	e1:SetOperation(c92080692.activate)
	c:RegisterEffect(e1)
end
function c92080692.condition(e,tp,eg,ep,ev,re,r,rp)
	return rp==1-tp and (re:IsActiveType(TYPE_MONSTER) or re:IsHasType(EFFECT_TYPE_ACTIVATE))
		and Duel.IsExistingMatchingCard(Card.IsCode,tp,0,LOCATION_GRAVE,1,nil,re:GetHandler():GetCode())
		and Duel.IsChainNegatable(ev)
end
function c92080692.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
	if re:GetHandler():IsDestructable() and re:GetHandler():IsRelateToEffect(re) then
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,1,0,0)
	end
end
function c92080692.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.NegateActivation(ev) and re:GetHandler():IsRelateToEffect(re) then
		Duel.Destroy(eg,REASON_EFFECT)
	end
end
