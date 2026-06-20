--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:31
-- Card: 星光大道  (ID: 58120309)
-- Type: Trap
-- ATK 0 | DEF 0
--
-- Effect Text:
-- ①：要让自己场上的卡2张以上破坏的魔法·陷阱·怪兽的效果发动时才能发动。那个效果无效并破坏。那之后，可以把1只「星尘龙」从额外卡组特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--スターライト・ロード
function c58120309.initial_effect(c)
	aux.AddCodeList(c,44508094)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_DISABLE+CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_CHAINING)
	e1:SetCondition(c58120309.condition)
	e1:SetTarget(c58120309.target)
	e1:SetOperation(c58120309.activate)
	c:RegisterEffect(e1)
end
function c58120309.filter(c,p)
	return c:GetControler()==p and c:IsOnField()
end
function c58120309.condition(e,tp,eg,ep,ev,re,r,rp)
	if not Duel.IsChainNegatable(ev) then return false end
	local ex,tg,tc=Duel.GetOperationInfo(ev,CATEGORY_DESTROY)
	return ex and tg~=nil and tc+tg:FilterCount(c58120309.filter,nil,tp)-tg:GetCount()>1
end
function c58120309.sfilter(c,e,tp)
	return c:IsCode(44508094) and c:IsCanBeSpecialSummoned(e,0,tp,false,false) and Duel.GetLocationCountFromEx(tp,tp,nil,c)>0
end
function c58120309.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DISABLE,eg,1,0,0)
	if re:GetHandler():IsDestructable() and re:GetHandler():IsRelateToEffect(re) then
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,1,0,0)
	end
end
function c58120309.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.NegateEffect(ev) and re:GetHandler():IsRelateToEffect(re) and Duel.Destroy(eg,REASON_EFFECT)~=0 then
		local sc=Duel.GetFirstMatchingCard(c58120309.sfilter,tp,LOCATION_EXTRA,0,nil,e,tp)
		if sc and Duel.SelectYesNo(tp,aux.Stringid(58120309,0)) then
			Duel.BreakEffect()
			Duel.SpecialSummon(sc,0,tp,tp,false,false,POS_FACEUP)
		end
	end
end
