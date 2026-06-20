--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 神之摄理  (ID: 38891741)
-- Type: Trap / Flip
-- ATK 0 | DEF 0
--
-- Effect Text:
-- ①：怪兽的效果·魔法·陷阱卡发动时，把和那个效果相同种类（怪兽·魔法·陷阱）的1张卡从手卡丢弃才能发动。那个发动无效并破坏。
--[[ __CARD_HEADER_END__ ]]

--神の摂理
function c38891741.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_NEGATE+CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_CHAINING)
	e1:SetCondition(c38891741.condition)
	e1:SetCost(c38891741.cost)
	e1:SetTarget(c38891741.target)
	e1:SetOperation(c38891741.activate)
	c:RegisterEffect(e1)
end
function c38891741.condition(e,tp,eg,ep,ev,re,r,rp)
	return (re:IsActiveType(TYPE_MONSTER) or re:IsHasType(EFFECT_TYPE_ACTIVATE)) and Duel.IsChainNegatable(ev)
end
function c38891741.cfilter(c,type)
	return c:IsType(type) and c:IsDiscardable()
end
function c38891741.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if Duel.IsPlayerAffectedByEffect(tp,EFFECT_DISCARD_COST_CHANGE) then return true end
	local type=bit.band(re:GetActiveType(),0x7)
	if chk==0 then return Duel.IsExistingMatchingCard(c38891741.cfilter,tp,LOCATION_HAND,0,1,nil,type) end
	Duel.DiscardHand(tp,c38891741.cfilter,1,1,REASON_COST+REASON_DISCARD,nil,type)
end
function c38891741.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
	if re:GetHandler():IsDestructable() and re:GetHandler():IsRelateToEffect(re) then
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,1,0,0)
	end
end
function c38891741.activate(e,tp,eg,ep,ev,re,r,rp)
	if not Duel.NegateActivation(ev) then return end
	if re:GetHandler():IsRelateToEffect(re) then
		Duel.Destroy(eg,REASON_EFFECT)
	end
end
