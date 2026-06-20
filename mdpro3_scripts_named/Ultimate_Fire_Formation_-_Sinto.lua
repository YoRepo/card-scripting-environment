--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:30
-- Card: 极炎舞-「辰斗」  (ID: 55538156)
-- Type: Trap / Flip
-- ATK 0 | DEF 0
-- Setcode: 124
--
-- Effect Text:
-- 这个卡名的卡在1回合只能发动1张。
-- ①：自己场上有「炎星」怪兽以及「炎舞」魔法·陷阱卡存在，魔法·陷阱卡发动时才能发动。那个发动无效并破坏。
--[[ __CARD_HEADER_END__ ]]

--極炎舞－「辰斗」
function c55538156.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_NEGATE+CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_CHAINING)
	e1:SetCountLimit(1,55538156+EFFECT_COUNT_CODE_OATH)
	e1:SetCondition(c55538156.condition)
	e1:SetTarget(c55538156.target)
	e1:SetOperation(c55538156.activate)
	c:RegisterEffect(e1)
end
function c55538156.cfilter1(c)
	return c:IsFaceup() and c:IsSetCard(0x79)
end
function c55538156.cfilter2(c)
	return c:IsFaceup() and c:IsSetCard(0x7c) and c:IsType(TYPE_SPELL+TYPE_TRAP)
end
function c55538156.condition(e,tp,eg,ep,ev,re,r,rp)
	return re:IsHasType(EFFECT_TYPE_ACTIVATE) and Duel.IsChainNegatable(ev)
		and Duel.IsExistingMatchingCard(c55538156.cfilter1,tp,LOCATION_MZONE,0,1,nil)
		and Duel.IsExistingMatchingCard(c55538156.cfilter2,tp,LOCATION_ONFIELD,0,1,nil)
end
function c55538156.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	if re:GetHandler():IsRelateToEffect(re) and re:GetHandler():IsDestructable() then
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,re:GetHandler(),1,0,0)
	end
end
function c55538156.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.NegateActivation(ev) and re:GetHandler():IsRelateToEffect(re) then
		Duel.Destroy(re:GetHandler(),REASON_EFFECT)
	end
end
