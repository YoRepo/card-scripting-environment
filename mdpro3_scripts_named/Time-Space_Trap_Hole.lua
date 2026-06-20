--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:24
-- Card: 时空的落穴  (ID: 2055403)
-- Type: Trap
-- ATK 0 | DEF 0
-- Setcode: 76
--
-- Effect Text:
-- ①：对方从手卡·额外卡组把怪兽特殊召唤时才能发动。从手卡·额外卡组特殊召唤的那些怪兽回到持有者卡组。那之后，自己失去回去的怪兽数量×1000基本分。
--[[ __CARD_HEADER_END__ ]]

--時空の落とし穴
function c2055403.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TODECK)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetTarget(c2055403.target)
	e1:SetOperation(c2055403.activate)
	c:RegisterEffect(e1)
end
function c2055403.filter(c,tp)
	return c:IsSummonPlayer(1-tp) and c:IsSummonLocation(LOCATION_HAND+LOCATION_EXTRA)
		and c:IsAbleToDeck() and c:IsLocation(LOCATION_MZONE)
end
function c2055403.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local g=eg:Filter(c2055403.filter,nil,tp)
	local ct=g:GetCount()
	if chk==0 then return ct>0 end
	Duel.SetTargetCard(eg)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,g,ct,0,0)
end
function c2055403.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=eg:Filter(c2055403.filter,nil,tp):Filter(Card.IsRelateToEffect,nil,e)
	if g:GetCount()>0 then
		Duel.SendtoDeck(g,nil,SEQ_DECKSHUFFLE,REASON_EFFECT)
		local og=Duel.GetOperatedGroup()
		local ct=og:FilterCount(Card.IsLocation,nil,LOCATION_DECK+LOCATION_EXTRA)
		if ct>0 then
			Duel.BreakEffect()
			Duel.SetLP(tp,Duel.GetLP(tp)-ct*1000)
		end
	end
end
