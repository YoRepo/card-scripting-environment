--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:31
-- Card: 电气抵消  (ID: 56993276)
-- Type: Trap / Flip
-- ATK 0 | DEF 0
-- Setcode: 14
--
-- Effect Text:
-- 从手卡丢弃1只名字带有「电气」的怪兽发动。对方怪兽的召唤·特殊召唤无效并破坏。
--[[ __CARD_HEADER_END__ ]]

--エレキャンセル
function c56993276.initial_effect(c)
	--Activate(summon)
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DISABLE_SUMMON+CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_SUMMON)
	e1:SetCondition(c56993276.condition)
	e1:SetCost(c56993276.cost)
	e1:SetTarget(c56993276.target)
	e1:SetOperation(c56993276.activate)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EVENT_SPSUMMON)
	c:RegisterEffect(e2)
end
function c56993276.condition(e,tp,eg,ep,ev,re,r,rp)
	return aux.NegateSummonCondition() and eg:IsExists(Card.IsControler,1,nil,1-tp)
end
function c56993276.cfilter(c)
	return c:IsSetCard(0xe) and c:IsType(TYPE_MONSTER) and c:IsDiscardable()
end
function c56993276.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if Duel.IsPlayerAffectedByEffect(tp,EFFECT_DISCARD_COST_CHANGE) then return true end
	if chk==0 then return Duel.IsExistingMatchingCard(c56993276.cfilter,tp,LOCATION_HAND,0,1,nil) end
	Duel.DiscardHand(tp,c56993276.cfilter,1,1,REASON_COST+REASON_DISCARD,nil)
end
function c56993276.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local g=eg:Filter(Card.IsControler,nil,1-tp)
	Duel.SetOperationInfo(0,CATEGORY_DISABLE_SUMMON,g,g:GetCount(),0,0)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
end
function c56993276.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=eg:Filter(Card.IsControler,nil,1-tp)
	Duel.NegateSummon(g)
	Duel.Destroy(g,REASON_EFFECT)
end
