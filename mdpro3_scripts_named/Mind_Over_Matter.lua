--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:31
-- Card: 布朗宁力  (ID: 59718521)
-- Type: Trap / Flip
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 把自己场上存在的1只念动力族怪兽解放发动。魔法·陷阱卡的发动、怪兽的召唤·特殊召唤的其中1个无效并破坏。
--[[ __CARD_HEADER_END__ ]]

--ブローニング・パワー
function c59718521.initial_effect(c)
	--Activate(summon)
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DISABLE_SUMMON+CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_SUMMON)
	e1:SetCondition(aux.NegateSummonCondition)
	e1:SetCost(c59718521.cost)
	e1:SetTarget(c59718521.target1)
	e1:SetOperation(c59718521.activate1)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EVENT_SPSUMMON)
	c:RegisterEffect(e2)
	--Activate(effect)
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_NEGATE+CATEGORY_DESTROY)
	e3:SetType(EFFECT_TYPE_ACTIVATE)
	e3:SetCode(EVENT_CHAINING)
	e3:SetCondition(c59718521.condition2)
	e3:SetCost(c59718521.cost)
	e3:SetTarget(c59718521.target2)
	e3:SetOperation(c59718521.activate2)
	c:RegisterEffect(e3)
end
function c59718521.filter(c)
	return c:IsRace(RACE_PSYCHO) and not c:IsStatus(STATUS_BATTLE_DESTROYED)
end
function c59718521.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckReleaseGroup(tp,c59718521.filter,1,nil) end
	local g=Duel.SelectReleaseGroup(tp,c59718521.filter,1,1,nil)
	Duel.Release(g,REASON_COST)
end
function c59718521.target1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DISABLE_SUMMON,eg,eg:GetCount(),0,0)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,eg:GetCount(),0,0)
end
function c59718521.activate1(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateSummon(eg)
	Duel.Destroy(eg,REASON_EFFECT)
end
function c59718521.condition2(e,tp,eg,ep,ev,re,r,rp)
	return re:IsHasType(EFFECT_TYPE_ACTIVATE) and Duel.IsChainNegatable(ev)
end
function c59718521.target2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
	if re:GetHandler():IsDestructable() and re:GetHandler():IsRelateToEffect(re) then
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,1,0,0)
	end
end
function c59718521.activate2(e,tp,eg,ep,ev,re,r,rp)
	if Duel.NegateActivation(ev) and re:GetHandler():IsRelateToEffect(re) then
		Duel.Destroy(eg,REASON_EFFECT)
	end
end
