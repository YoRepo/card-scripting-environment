--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: 航空母舰机人  (ID: 46848859)
-- Type: Monster / Effect
-- Attribute: WATER
-- Race: Machine
-- Level 4
-- ATK 1000 | DEF 800
-- Setcode: 22
--
-- Effect Text:
-- 对方以自己场上的魔法·陷阱卡为对象把持有使场上的魔法·陷阱卡破坏效果的卡发动时，可以丢弃1张手卡，那张卡的发动和效果无效并破坏。
--[[ __CARD_HEADER_END__ ]]

--ネイビィロイド
function c46848859.initial_effect(c)
	--Negate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(46848859,0))
	e1:SetCategory(CATEGORY_NEGATE+CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_CHAINING)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(c46848859.condition)
	e1:SetCost(c46848859.cost)
	e1:SetTarget(c46848859.target)
	e1:SetOperation(c46848859.operation)
	c:RegisterEffect(e1)
end
function c46848859.cfilter(c)
	return c:IsOnField() and c:IsType(TYPE_SPELL+TYPE_TRAP)
end
function c46848859.tgfilter(c,tp)
	return c:IsOnField() and c:IsControler(tp) and c:IsType(TYPE_SPELL+TYPE_TRAP)
end
function c46848859.condition(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():IsStatus(STATUS_BATTLE_DESTROYED) or not Duel.IsChainNegatable(ev) then return false end
	if not re:IsHasProperty(EFFECT_FLAG_CARD_TARGET) then return false end
	local g=Duel.GetChainInfo(ev,CHAININFO_TARGET_CARDS)
	if not g or not g:IsExists(c46848859.tgfilter,1,nil,tp) then return false end
	if re:IsHasCategory(CATEGORY_NEGATE)
		and Duel.GetChainInfo(ev-1,CHAININFO_TRIGGERING_EFFECT):IsHasType(EFFECT_TYPE_ACTIVATE) then return false end
	local ex,tg,tc=Duel.GetOperationInfo(ev,CATEGORY_DESTROY)
	return ex and tg~=nil and tc+tg:FilterCount(c46848859.cfilter,nil)-tg:GetCount()>0
end
function c46848859.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsDiscardable,tp,LOCATION_HAND,0,1,nil) end
	Duel.DiscardHand(tp,Card.IsDiscardable,1,1,REASON_COST+REASON_DISCARD)
end
function c46848859.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
	if re:GetHandler():IsDestructable() and re:GetHandler():IsRelateToEffect(re) then
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,1,0,0)
	end
end
function c46848859.operation(e,tp,eg,ep,ev,re,r,rp)
	if Duel.NegateActivation(ev) and re:GetHandler():IsRelateToEffect(re) then
		Duel.Destroy(eg,REASON_EFFECT)
	end
end
