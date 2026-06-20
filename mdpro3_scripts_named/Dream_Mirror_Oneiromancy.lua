--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:31
-- Card: 梦魔镜的梦占  (ID: 61459246)
-- Type: Trap / Flip
-- ATK 0 | DEF 0
-- Setcode: 305
--
-- Effect Text:
-- 这个卡名的卡在1回合只能发动1张。
-- ①：可以把以下效果发动。
-- ●场地区域有「圣光之梦魔镜」存在，对方把魔法·陷阱卡发动时才能发动。那个发动无效并破坏。
-- ●场地区域有「黯黑之梦魔镜」存在，对方把怪兽特殊召唤之际才能发动。那次特殊召唤无效，那些怪兽破坏。
--[[ __CARD_HEADER_END__ ]]

--夢魔鏡の夢占い
function c61459246.initial_effect(c)
	aux.AddCodeList(c,74665651,1050355)
	--activate(effect)
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_NEGATE+CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_CHAINING)
	e1:SetCountLimit(1,61459246+EFFECT_COUNT_CODE_OATH)
	e1:SetCondition(c61459246.condition1)
	e1:SetTarget(c61459246.target1)
	e1:SetOperation(c61459246.activate1)
	c:RegisterEffect(e1)
	--activate(spsummon)
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_DISABLE_SUMMON+CATEGORY_DESTROY)
	e2:SetType(EFFECT_TYPE_ACTIVATE)
	e2:SetCode(EVENT_SPSUMMON)
	e2:SetCountLimit(1,61459246+EFFECT_COUNT_CODE_OATH)
	e2:SetCondition(c61459246.condition2)
	e2:SetTarget(c61459246.target2)
	e2:SetOperation(c61459246.activate2)
	c:RegisterEffect(e2)
end
function c61459246.condition1(e,tp,eg,ep,ev,re,r,rp)
	return re:IsHasType(EFFECT_TYPE_ACTIVATE) and Duel.IsChainNegatable(ev) and rp==1-tp and Duel.IsEnvironment(74665651,PLAYER_ALL,LOCATION_FZONE)
end
function c61459246.target1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
	if re:GetHandler():IsDestructable() and re:GetHandler():IsRelateToEffect(re) then
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,1,0,0)
	end
end
function c61459246.activate1(e,tp,eg,ep,ev,re,r,rp)
	if Duel.NegateActivation(ev) and re:GetHandler():IsRelateToEffect(re) then
		Duel.Destroy(eg,REASON_EFFECT)
	end
end
function c61459246.condition2(e,tp,eg,ep,ev,re,r,rp)
	return aux.NegateSummonCondition() and rp==1-tp and Duel.IsEnvironment(1050355,PLAYER_ALL,LOCATION_FZONE)
end
function c61459246.target2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DISABLE_SUMMON,eg,eg:GetCount(),0,0)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,eg:GetCount(),0,0)
end
function c61459246.activate2(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateSummon(eg)
	Duel.Destroy(eg,REASON_EFFECT)
end
