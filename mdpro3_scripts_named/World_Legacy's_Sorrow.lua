--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:52
-- Source DB: cards.cdb
-- Card: World Legacy's Sorrow  (ID: 85763457)
-- Type: Trap / Counter
-- Setcode: 0xfe
-- Scope: OCG / TCG
--
-- Effect Text:
-- When your opponent activates a Spell/Trap Card, or monster effect, while you control a co-linked
-- monster(s): Negate the activation, and if you do, destroy that card.
-- You can only activate 1 "World Legacy's Sorrow" per turn.
--[[ __CARD_HEADER_END__ ]]

--星遺物に響く残叫
function c85763457.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_NEGATE+CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_CHAINING)
	e1:SetCountLimit(1,85763457+EFFECT_COUNT_CODE_OATH)
	e1:SetCondition(c85763457.condition)
	e1:SetTarget(c85763457.target)
	e1:SetOperation(c85763457.activate)
	c:RegisterEffect(e1)
end
function c85763457.cfilter(c)
	return c:IsFaceup() and c:GetMutualLinkedGroupCount()>0
end
function c85763457.condition(e,tp,eg,ep,ev,re,r,rp)
	if ep==tp or not Duel.IsExistingMatchingCard(c85763457.cfilter,tp,LOCATION_MZONE,0,1,nil) then return false end
	return Duel.IsChainNegatable(ev) and (re:IsActiveType(TYPE_MONSTER) or re:IsHasType(EFFECT_TYPE_ACTIVATE))
end
function c85763457.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
	if re:GetHandler():IsDestructable() and re:GetHandler():IsRelateToEffect(re) then
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,1,0,0)
	end
end
function c85763457.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.NegateActivation(ev) and re:GetHandler():IsRelateToEffect(re) then
		Duel.Destroy(eg,REASON_EFFECT)
	end
end
