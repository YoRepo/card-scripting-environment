--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:53
-- Source DB: cards.cdb
-- Card: Smashing Horn  (ID: 93396832)
-- Type: Trap / Counter
-- Scope: OCG / TCG
--
-- Effect Text:
-- When a monster effect or Trap Card is activated that negates the Normal or Special Summon of a
-- monster(s): Negate the activation and destroy it.
--[[ __CARD_HEADER_END__ ]]

--角笛砕き
function c93396832.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_NEGATE+CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_CHAINING)
	e1:SetCondition(c93396832.condition)
	e1:SetTarget(c93396832.target)
	e1:SetOperation(c93396832.activate)
	c:RegisterEffect(e1)
end
function c93396832.condition(e,tp,eg,ep,ev,re,r,rp)
	return (re:IsActiveType(TYPE_MONSTER) or (re:IsActiveType(TYPE_TRAP) and re:IsHasType(EFFECT_TYPE_ACTIVATE)))
		and re:IsHasCategory(CATEGORY_DISABLE_SUMMON) and Duel.IsChainNegatable(ev)
end
function c93396832.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
	if re:GetHandler():IsDestructable() and re:GetHandler():IsRelateToEffect(re) then
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,1,0,0)
	end
end
function c93396832.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.NegateActivation(ev) and re:GetHandler():IsRelateToEffect(re) then
		Duel.Destroy(eg,REASON_EFFECT)
	end
end
