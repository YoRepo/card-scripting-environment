--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:53
-- Source DB: cards.cdb
-- Card: Infernity Barrier  (ID: 9059700)
-- Type: Trap / Counter
-- Setcode: 0xb
-- Scope: OCG / TCG
--
-- Effect Text:
-- When your opponent activates a Spell/Trap Card, or monster effect, while you control a face-up
-- Attack Position "Infernity" monster and have no cards in your hand: Negate the activation, and if
-- you do, destroy that card.
--[[ __CARD_HEADER_END__ ]]

--インフェルニティ・バリア
function c9059700.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_NEGATE+CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_CHAINING)
	e1:SetCondition(c9059700.condition)
	e1:SetTarget(c9059700.target)
	e1:SetOperation(c9059700.activate)
	c:RegisterEffect(e1)
end
function c9059700.cfilter(c)
	return c:IsPosition(POS_FACEUP_ATTACK) and c:IsSetCard(0xb)
end
function c9059700.condition(e,tp,eg,ep,ev,re,r,rp)
	if ep==tp or not Duel.IsExistingMatchingCard(c9059700.cfilter,tp,LOCATION_MZONE,0,1,nil)
		or Duel.GetFieldGroupCount(tp,LOCATION_HAND,0)~=0 then return false end
	return Duel.IsChainNegatable(ev) and (re:IsActiveType(TYPE_MONSTER) or re:IsHasType(EFFECT_TYPE_ACTIVATE))
end
function c9059700.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
	if re:GetHandler():IsDestructable() and re:GetHandler():IsRelateToEffect(re) then
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,1,0,0)
	end
end
function c9059700.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.NegateActivation(ev) and re:GetHandler():IsRelateToEffect(re) then
		Duel.Destroy(eg,REASON_EFFECT)
	end
end
