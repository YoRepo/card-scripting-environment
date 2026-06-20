--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: 反射之圣刻印  (ID: 47360060)
-- Type: Trap / Flip
-- ATK 0 | DEF 0
-- Setcode: 105
--
-- Effect Text:
-- 把自己场上1只名字带有「圣刻」的怪兽解放才能发动。效果怪兽的效果·魔法·陷阱卡的发动无效并破坏。
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
