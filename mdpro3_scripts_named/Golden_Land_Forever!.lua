--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:49
-- Source DB: cards.cdb
-- Card: Golden Land Forever!  (ID: 56984514)
-- Type: Trap / Counter
-- Setcode: 0x143
-- Scope: OCG / TCG
--
-- Effect Text:
-- When a Spell/Trap Card, or monster effect, is activated, while you control an "Eldlich" monster:
-- Tribute 1 Zombie monster; negate the activation, and if you do, destroy that card.
-- You can only activate 1 "Golden Land Forever!" per turn.
--[[ __CARD_HEADER_END__ ]]

--永久に輝けし黄金郷
function c56984514.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_NEGATE+CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_CHAINING)
	e1:SetCountLimit(1,56984514+EFFECT_COUNT_CODE_OATH)
	e1:SetCondition(c56984514.condition)
	e1:SetCost(c56984514.cost)
	e1:SetTarget(c56984514.target)
	e1:SetOperation(c56984514.activate)
	c:RegisterEffect(e1)
end
function c56984514.filter(c)
	return c:IsSetCard(0x1142) and c:IsFaceup()
end
function c56984514.condition(e,tp,eg,ep,ev,re,r,rp)
	return (re:IsActiveType(TYPE_MONSTER) or re:IsHasType(EFFECT_TYPE_ACTIVATE)) and Duel.IsChainNegatable(ev)
		and Duel.IsExistingMatchingCard(c56984514.filter,tp,LOCATION_MZONE,0,1,nil)
end
function c56984514.cfilter(c,tp)
	return c:IsRace(RACE_ZOMBIE) and (c:IsControler(tp) or c:IsFaceup()) and not c:IsStatus(STATUS_BATTLE_DESTROYED)
end
function c56984514.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckReleaseGroup(tp,c56984514.cfilter,1,nil,tp) end
	local sg=Duel.SelectReleaseGroup(tp,c56984514.cfilter,1,1,nil,tp)
	Duel.Release(sg,REASON_COST)
end
function c56984514.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
	if re:GetHandler():IsDestructable() and re:GetHandler():IsRelateToEffect(re) then
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,1,0,0)
	end
end
function c56984514.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.NegateActivation(ev) and re:GetHandler():IsRelateToEffect(re) then
		Duel.Destroy(eg,REASON_EFFECT)
	end
end
