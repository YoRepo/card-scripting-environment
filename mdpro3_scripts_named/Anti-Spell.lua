--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:48
-- Source DB: cards.cdb
-- Card: Anti-Spell  (ID: 53112492)
-- Type: Trap / Counter
-- Scope: OCG / TCG
--
-- Effect Text:
-- Remove 2 Spell Counters on your side of the field to negate the activation of a Spell Card and
-- destroy it.
--[[ __CARD_HEADER_END__ ]]

--対抗魔術
function c53112492.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_NEGATE+CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_CHAINING)
	e1:SetCondition(c53112492.condition)
	e1:SetCost(c53112492.cost)
	e1:SetTarget(c53112492.target)
	e1:SetOperation(c53112492.activate)
	c:RegisterEffect(e1)
end
function c53112492.condition(e,tp,eg,ep,ev,re,r,rp)
	return re:IsActiveType(TYPE_SPELL) and re:IsHasType(EFFECT_TYPE_ACTIVATE) and Duel.IsChainNegatable(ev)
end
function c53112492.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsCanRemoveCounter(tp,1,0,0x1,2,REASON_COST) end
	Duel.RemoveCounter(tp,1,0,0x1,2,REASON_COST)
end
function c53112492.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
	if re:GetHandler():IsDestructable() and re:GetHandler():IsRelateToEffect(re) then
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,1,0,0)
	end
end
function c53112492.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.NegateActivation(ev) and re:GetHandler():IsRelateToEffect(re) then
		Duel.Destroy(eg,REASON_EFFECT)
	end
end
