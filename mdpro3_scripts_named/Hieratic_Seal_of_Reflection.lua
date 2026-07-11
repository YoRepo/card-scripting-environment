--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:47
-- Source DB: cards.cdb
-- Card: Hieratic Seal of Reflection  (ID: 47360060)
-- Type: Trap / Counter
-- Setcode: 0x69
-- Scope: OCG / TCG
--
-- Effect Text:
-- When a Spell/Trap Card, or monster effect is activated: Tribute 1 "Hieratic" monster; negate the
-- activation, and if you do, destroy it.
--[[ __CARD_HEADER_END__ ]]

--反射の聖刻印
function c47360060.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_NEGATE+CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_CHAINING)
	e1:SetCondition(c47360060.condition)
	e1:SetCost(c47360060.cost)
	e1:SetTarget(c47360060.target)
	e1:SetOperation(c47360060.activate)
	c:RegisterEffect(e1)
end
function c47360060.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsChainNegatable(ev) and (re:IsActiveType(TYPE_MONSTER) or re:IsHasType(EFFECT_TYPE_ACTIVATE))
end
function c47360060.cfilter(c)
	return c:IsSetCard(0x69) and not c:IsStatus(STATUS_BATTLE_DESTROYED)
end
function c47360060.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckReleaseGroup(tp,c47360060.cfilter,1,nil) end
	local g=Duel.SelectReleaseGroup(tp,c47360060.cfilter,1,1,nil)
	Duel.Release(g,REASON_COST)
end
function c47360060.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
	if re:GetHandler():IsDestructable() and re:GetHandler():IsRelateToEffect(re) then
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,1,0,0)
	end
end
function c47360060.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.NegateActivation(ev) and re:GetHandler():IsRelateToEffect(re) then
		Duel.Destroy(eg,REASON_EFFECT)
	end
end
