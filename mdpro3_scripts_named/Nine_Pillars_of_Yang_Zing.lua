--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:31
-- Card: 龙星的九支  (ID: 57831349)
-- Type: Trap / Flip
-- ATK 0 | DEF 0
-- Setcode: 158
--
-- Effect Text:
-- ①：自己场上有「龙星」卡存在，怪兽的效果·魔法·陷阱卡发动时才能发动。那个发动无效，那张卡回到持有者卡组。那之后，选这张卡以外的自己场上1张「龙星」卡破坏。
--[[ __CARD_HEADER_END__ ]]

--竜星の九支
function c57831349.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_NEGATE+CATEGORY_TODECK+CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_CHAINING)
	e1:SetCondition(c57831349.condition)
	e1:SetTarget(c57831349.target)
	e1:SetOperation(c57831349.activate)
	c:RegisterEffect(e1)
end
function c57831349.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x9e)
end
function c57831349.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c57831349.cfilter,tp,LOCATION_ONFIELD,0,1,nil)
		and (re:IsActiveType(TYPE_MONSTER) or re:IsHasType(EFFECT_TYPE_ACTIVATE)) and Duel.IsChainNegatable(ev)
end
function c57831349.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return aux.ndcon(tp,re) end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
	if re:GetHandler():IsRelateToEffect(re) then
		Duel.SetOperationInfo(0,CATEGORY_TODECK,eg,1,0,0)
	end
end
function c57831349.desfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x9e)
end
function c57831349.activate(e,tp,eg,ep,ev,re,r,rp)
	local ec=re:GetHandler()
	if Duel.NegateActivation(ev) and ec:IsRelateToEffect(re) then
		ec:CancelToGrave()
		if Duel.SendtoDeck(ec,nil,SEQ_DECKSHUFFLE,REASON_EFFECT)~=0 and ec:IsLocation(LOCATION_DECK+LOCATION_EXTRA) then
			local g=Duel.GetMatchingGroup(c57831349.desfilter,tp,LOCATION_ONFIELD,0,aux.ExceptThisCard(e))
			if g:GetCount()>0 then
				Duel.BreakEffect()
				Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
				local sg=g:Select(tp,1,1,nil)
				Duel.Destroy(sg,REASON_EFFECT)
			end
		end
	end
end
