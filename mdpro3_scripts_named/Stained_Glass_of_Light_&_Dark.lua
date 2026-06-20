--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 圣邪之彩色玻璃花窗  (ID: 16598965)
-- Type: Trap
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 这个卡名的卡在1回合只能发动1张。
-- ①：自己场上的效果怪兽的种族的以下效果各能适用。
-- ●天使族：自己抽3张。那之后，选2张手卡用喜欢的顺序回到卡组下面。
-- ●恶魔族：对方抽1张。那之后，对方把手卡随机1张丢弃。并且对方在有手卡的场合再选1张丢弃。
--[[ __CARD_HEADER_END__ ]]

--聖邪のステンドグラス
function c16598965.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(16598965,0))
	e1:SetCategory(CATEGORY_DRAW+CATEGORY_TODECK+CATEGORY_HANDES)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,16598965)
	e1:SetTarget(c16598965.target)
	e1:SetOperation(c16598965.activate)
	c:RegisterEffect(e1)
end
function c16598965.filter(c,race)
	return c:IsRace(race) and c:IsType(TYPE_EFFECT) and c:IsFaceup()
end
function c16598965.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local f1=Duel.IsExistingMatchingCard(c16598965.filter,tp,LOCATION_MZONE,0,1,nil,RACE_FAIRY) and Duel.IsPlayerCanDraw(tp,3)
	local f2=Duel.IsExistingMatchingCard(c16598965.filter,tp,LOCATION_MZONE,0,1,nil,RACE_FIEND) and Duel.IsPlayerCanDraw(1-tp,1)
	if chk==0 then return f1 or f2 end
end
function c16598965.activate(e,tp,eg,ep,ev,re,r,rp)
	local f1=Duel.IsExistingMatchingCard(c16598965.filter,tp,LOCATION_MZONE,0,1,nil,RACE_FAIRY) and Duel.IsPlayerCanDraw(tp,3)
	local f2=Duel.IsExistingMatchingCard(c16598965.filter,tp,LOCATION_MZONE,0,1,nil,RACE_FIEND) and Duel.IsPlayerCanDraw(1-tp,1)
	local res=false
	if f1 and (not f2 or Duel.SelectYesNo(tp,aux.Stringid(16598965,1))) and Duel.Draw(tp,3,REASON_EFFECT)==3 then
		res=true
		local g=Duel.GetMatchingGroup(Card.IsAbleToDeck,tp,LOCATION_HAND,0,nil)
		if g:GetCount()<2 then return end
		Duel.ShuffleHand(tp)
		Duel.BreakEffect()
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
		local sg=g:Select(tp,2,2,nil)
		aux.PlaceCardsOnDeckBottom(tp,sg)
	end
	if f2 and (not res or Duel.SelectYesNo(tp,aux.Stringid(16598965,2))) and Duel.Draw(1-tp,1,REASON_EFFECT)==1 then
		Duel.ShuffleHand(1-tp)
		Duel.BreakEffect()
		local g=Duel.GetFieldGroup(1-tp,LOCATION_HAND,0)
		if #g==0 then return end
		local sg=g:RandomSelect(1-tp,1)
		Duel.SendtoGrave(sg,REASON_DISCARD+REASON_EFFECT)
		local g1=Duel.GetFieldGroup(1-tp,LOCATION_HAND,0)
		if #g1==0 then return end
		Duel.BreakEffect()
		Duel.DiscardHand(1-tp,aux.TRUE,1,1,REASON_EFFECT+REASON_DISCARD)
	end
end
