--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:37
-- Card: 连锁空穴  (ID: 9581215)
-- Type: Trap
-- ATK 0 | DEF 0
-- Setcode: 137
--
-- Effect Text:
-- ①：对方连锁魔法·陷阱·怪兽的效果的发动把怪兽的效果发动时才能发动。那个效果无效。那之后，对方可以从手卡·卡组选原本卡名和用这个效果无效的卡相同的1张卡除外。没有除外的场合，自己可以把对方手卡随机选1
-- 张除外。
--[[ __CARD_HEADER_END__ ]]

--連鎖空穴
function c9581215.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DISABLE+CATEGORY_REMOVE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_CHAINING)
	e1:SetCondition(c9581215.condition)
	e1:SetTarget(c9581215.target)
	e1:SetOperation(c9581215.activate)
	c:RegisterEffect(e1)
end
function c9581215.condition(e,tp,eg,ep,ev,re,r,rp)
	return ev>1 and rp==1-tp and re:IsActiveType(TYPE_MONSTER) and Duel.IsChainDisablable(ev)
end
function c9581215.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DISABLE,eg,1,0,0)
end
function c9581215.rmfilter(c,p,tc)
	return c:IsAbleToRemove(p) and c:IsOriginalCodeRule(tc:GetOriginalCodeRule())
end
function c9581215.activate(e,tp,eg,ep,ev,re,r,rp)
	if not Duel.NegateEffect(ev) then return end
	Duel.BreakEffect()
	local sel=1
	local g=Duel.GetMatchingGroup(c9581215.rmfilter,tp,0,LOCATION_HAND+LOCATION_DECK,nil,1-tp,eg:GetFirst())
	local tg=Duel.GetMatchingGroup(Card.IsAbleToRemove,tp,0,LOCATION_HAND,nil)
	Duel.Hint(HINT_SELECTMSG,1-tp,aux.Stringid(9581215,0))
	if g:GetCount()>0 then
		sel=Duel.SelectOption(1-tp,1213,1214)
	else
		sel=Duel.SelectOption(1-tp,1214)+1
	end
	if sel==0 then
		Duel.Hint(HINT_SELECTMSG,1-tp,HINTMSG_REMOVE)
		local sg=g:Select(1-tp,1,1,nil)
		Duel.Remove(sg,POS_FACEUP,REASON_EFFECT)
	elseif #tg>0 and Duel.SelectYesNo(tp,aux.Stringid(9581215,1)) then
		local sg=tg:RandomSelect(tp,1)
		Duel.Remove(sg,POS_FACEUP,REASON_EFFECT)
	end
end
