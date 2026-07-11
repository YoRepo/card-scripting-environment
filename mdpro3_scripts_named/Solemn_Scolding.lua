--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:53
-- Source DB: cards.cdb
-- Card: Solemn Scolding  (ID: 92512625)
-- Type: Trap / Counter
-- Scope: OCG / TCG
--
-- Effect Text:
-- If this is the only Set card in your Spell & Trap Zone, when a monster(s) would be Summoned, OR a
-- Spell/Trap Card, or monster effect is activated: Pay 3000 LP; negate the Summon or activation, and
-- if you do, destroy that card.
--[[ __CARD_HEADER_END__ ]]

--神の忠告
function c92512625.initial_effect(c)
	--Activate(summon)
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DISABLE_SUMMON+CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_SUMMON)
	e1:SetCondition(c92512625.condition1)
	e1:SetCost(c92512625.cost)
	e1:SetTarget(c92512625.target1)
	e1:SetOperation(c92512625.activate1)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EVENT_FLIP_SUMMON)
	c:RegisterEffect(e2)
	local e3=e1:Clone()
	e3:SetCode(EVENT_SPSUMMON)
	c:RegisterEffect(e3)
	--Activate(effect)
	local e4=Effect.CreateEffect(c)
	e4:SetCategory(CATEGORY_NEGATE+CATEGORY_DESTROY)
	e4:SetType(EFFECT_TYPE_ACTIVATE)
	e4:SetCode(EVENT_CHAINING)
	e4:SetCondition(c92512625.condition2)
	e4:SetCost(c92512625.cost)
	e4:SetTarget(c92512625.target2)
	e4:SetOperation(c92512625.activate2)
	c:RegisterEffect(e4)
end
function c92512625.cfilter(c)
	return c:IsFacedown() and c:GetSequence()<5
end
function c92512625.condition(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsLocation(LOCATION_SZONE) and c:IsFacedown()
		and not Duel.IsExistingMatchingCard(c92512625.cfilter,tp,LOCATION_SZONE,0,1,c)
end
function c92512625.condition1(e,tp,eg,ep,ev,re,r,rp)
	return aux.NegateSummonCondition()
		and c92512625.condition(e,tp,eg,ep,ev,re,r,rp)
end
function c92512625.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(tp,3000) end
	Duel.PayLPCost(tp,3000)
end
function c92512625.target1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DISABLE_SUMMON,eg,eg:GetCount(),0,0)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,eg:GetCount(),0,0)
end
function c92512625.activate1(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateSummon(eg)
	Duel.Destroy(eg,REASON_EFFECT)
end
function c92512625.condition2(e,tp,eg,ep,ev,re,r,rp)
	return (re:IsActiveType(TYPE_MONSTER) or re:IsHasType(EFFECT_TYPE_ACTIVATE)) and Duel.IsChainNegatable(ev)
		and c92512625.condition(e,tp,eg,ep,ev,re,r,rp)
end
function c92512625.target2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
	if re:GetHandler():IsDestructable() and re:GetHandler():IsRelateToEffect(re) then
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,1,0,0)
	end
end
function c92512625.activate2(e,tp,eg,ep,ev,re,r,rp)
	if Duel.NegateActivation(ev) and re:GetHandler():IsRelateToEffect(re) then
		Duel.Destroy(eg,REASON_EFFECT)
	end
end
