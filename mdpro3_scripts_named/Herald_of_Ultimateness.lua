--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: 崇光之宣告者  (ID: 48546368)
-- Type: Monster / Effect / Ritual
-- Attribute: LIGHT
-- Race: Fairy
-- Level 12
-- ATK 2000 | DEF 3000
--
-- Effect Text:
-- 「宣告者的神托」降临。这张卡不用仪式召唤不能特殊召唤。
-- ①：可以从手卡把1只天使族怪兽送去墓地把以下效果发动。
-- ●对方把怪兽的效果·魔法·陷阱卡发动时才能发动。那个发动无效并破坏。
-- ●对方把怪兽特殊召唤之际才能发动。那次特殊召唤无效，那些怪兽破坏。
--[[ __CARD_HEADER_END__ ]]

--崇光なる宣告者
function c48546368.initial_effect(c)
	aux.AddCodeList(c,79306385)
	c:EnableReviveLimit()
	--spsummon condition
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetValue(aux.ritlimit)
	c:RegisterEffect(e1)
	--negate
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(48546368,0))
	e2:SetCategory(CATEGORY_NEGATE+CATEGORY_DESTROY)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_CHAINING)
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCondition(c48546368.negcon)
	e2:SetCost(c48546368.cost)
	e2:SetTarget(c48546368.negtg)
	e2:SetOperation(c48546368.negop)
	c:RegisterEffect(e2)
	--disable spsummon
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(48546368,1))
	e3:SetCategory(CATEGORY_DISABLE_SUMMON+CATEGORY_DESTROY)
	e3:SetType(EFFECT_TYPE_QUICK_O)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCode(EVENT_SPSUMMON)
	e3:SetCondition(c48546368.discon)
	e3:SetCost(c48546368.cost)
	e3:SetTarget(c48546368.distg)
	e3:SetOperation(c48546368.disop)
	c:RegisterEffect(e3)
end
function c48546368.negcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if ep==tp or c:IsStatus(STATUS_BATTLE_DESTROYED) then return false end
	return (re:IsActiveType(TYPE_MONSTER) or re:IsHasType(EFFECT_TYPE_ACTIVATE)) and Duel.IsChainNegatable(ev)
end
function c48546368.cfilter(c)
	return c:IsRace(RACE_FAIRY) and c:IsAbleToGraveAsCost()
end
function c48546368.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c48546368.cfilter,tp,LOCATION_HAND,0,1,nil) end
	Duel.DiscardHand(tp,c48546368.cfilter,1,1,REASON_COST)
end
function c48546368.negtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
	if re:GetHandler():IsDestructable() and re:GetHandler():IsRelateToEffect(re) then
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,1,0,0)
	end
end
function c48546368.negop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.NegateActivation(ev) and re:GetHandler():IsRelateToEffect(re) then
		Duel.Destroy(eg,REASON_EFFECT)
	end
end
function c48546368.filter(c,tp)
	return c:IsSummonPlayer(tp)
end
function c48546368.discon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetCurrentChain()==0 and eg:IsExists(c48546368.filter,1,nil,1-tp)
end
function c48546368.distg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local g=eg:Filter(c48546368.filter,nil,1-tp)
	Duel.SetOperationInfo(0,CATEGORY_DISABLE_SUMMON,g,g:GetCount(),0,0)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
end
function c48546368.disop(e,tp,eg,ep,ev,re,r,rp)
	local g=eg:Filter(c48546368.filter,nil,1-tp)
	Duel.NegateSummon(g)
	Duel.Destroy(g,REASON_EFFECT)
end
