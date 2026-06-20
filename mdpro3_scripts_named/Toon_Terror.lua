--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:30
-- Card: 卡通叙述者  (ID: 53094821)
-- Type: Trap / Flip
-- ATK 0 | DEF 0
-- Setcode: 98
--
-- Effect Text:
-- 这个卡名的卡在1回合只能发动1张。
-- ①：自己场上有「卡通世界」以及卡通怪兽存在，怪兽的效果·魔法·陷阱卡发动时才能发动。那个发动无效并破坏。
--[[ __CARD_HEADER_END__ ]]

--トゥーン・テラー
function c53094821.initial_effect(c)
	aux.AddCodeList(c,15259703)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_NEGATE+CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_CHAINING)
	e1:SetCountLimit(1,53094821+EFFECT_COUNT_CODE_OATH)
	e1:SetCondition(c53094821.condition)
	e1:SetTarget(c53094821.target)
	e1:SetOperation(c53094821.activate)
	c:RegisterEffect(e1)
end
function c53094821.cfilter1(c)
	return c:IsFaceup() and c:IsCode(15259703)
end
function c53094821.cfilter2(c)
	return c:IsFaceup() and c:IsType(TYPE_TOON)
end
function c53094821.condition(e,tp,eg,ep,ev,re,r,rp)
	return (re:IsActiveType(TYPE_MONSTER) or re:IsHasType(EFFECT_TYPE_ACTIVATE)) and Duel.IsChainNegatable(ev)
		and Duel.IsExistingMatchingCard(c53094821.cfilter1,tp,LOCATION_ONFIELD,0,1,nil)
		and Duel.IsExistingMatchingCard(c53094821.cfilter2,tp,LOCATION_MZONE,0,1,nil)
end
function c53094821.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
	if re:GetHandler():IsRelateToEffect(re) and re:GetHandler():IsDestructable() then
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,1,0,0)
	end
end
function c53094821.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.NegateActivation(ev) and re:GetHandler():IsRelateToEffect(re) then
		Duel.Destroy(eg,REASON_EFFECT)
	end
end
