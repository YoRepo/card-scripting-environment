--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:42
-- Source DB: cards.cdb
-- Card: Spell-Stopping Statute  (ID: 10069180)
-- Type: Trap / Counter
-- Scope: OCG / TCG
--
-- Effect Text:
-- Activate only when your opponent activates a Continuous Spell Card.
-- Negate the activation and the effect of the card and destroy it.
--[[ __CARD_HEADER_END__ ]]

--魔力終了宣告
function c10069180.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_NEGATE+CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_CHAINING)
	e1:SetCondition(c10069180.condition)
	e1:SetTarget(c10069180.target)
	e1:SetOperation(c10069180.activate)
	c:RegisterEffect(e1)
end
function c10069180.condition(e,tp,eg,ep,ev,re,r,rp)
	return rp==1-tp and re:IsHasType(EFFECT_TYPE_ACTIVATE) and re:GetActiveType()==TYPE_SPELL+TYPE_CONTINUOUS and Duel.IsChainNegatable(ev)
end
function c10069180.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
	if re:GetHandler():IsDestructable() and re:GetHandler():IsRelateToEffect(re) then
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,1,0,0)
	end
end
function c10069180.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.NegateActivation(ev) and re:GetHandler():IsRelateToEffect(re) then
		Duel.Destroy(eg,REASON_EFFECT)
	end
end
