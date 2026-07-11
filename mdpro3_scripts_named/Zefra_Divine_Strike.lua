--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:45
-- Source DB: cards.cdb
-- Card: Zefra Divine Strike  (ID: 35561352)
-- Type: Trap / Counter
-- Setcode: 0xc4
-- Scope: OCG / TCG
--
-- Effect Text:
-- When a Spell/Trap Card, or monster effect, is activated: Banish 1 face-up "Zefra" monster in your
-- Extra Deck; negate the activation, and if you do, destroy it.
--[[ __CARD_HEADER_END__ ]]

--セフィラの神撃
function c35561352.initial_effect(c)
	--Activate(effect)
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_NEGATE+CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_CHAINING)
	e1:SetCondition(c35561352.condition)
	e1:SetCost(c35561352.cost)
	e1:SetTarget(c35561352.target)
	e1:SetOperation(c35561352.activate)
	c:RegisterEffect(e1)
end
function c35561352.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0xc4) and c:IsAbleToRemoveAsCost()
end
function c35561352.condition(e,tp,eg,ep,ev,re,r,rp)
	return (re:IsActiveType(TYPE_MONSTER) or re:IsHasType(EFFECT_TYPE_ACTIVATE)) and Duel.IsChainNegatable(ev)
end
function c35561352.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c35561352.cfilter,tp,LOCATION_EXTRA,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,c35561352.cfilter,tp,LOCATION_EXTRA,0,1,1,nil)
	Duel.Remove(g,POS_FACEUP,REASON_COST)
end
function c35561352.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
	if re:GetHandler():IsDestructable() and re:GetHandler():IsRelateToEffect(re) then
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,1,0,0)
	end
end
function c35561352.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.NegateActivation(ev) and re:GetHandler():IsRelateToEffect(re) then
		Duel.Destroy(eg,REASON_EFFECT)
	end
end
