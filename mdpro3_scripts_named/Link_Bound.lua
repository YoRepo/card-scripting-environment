--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: 出入连接  (ID: 51335426)
-- Type: Spell / Continuous
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 这个卡名的卡在1回合只能发动1张。
-- ①：以自己的场上·墓地1只连接怪兽为对象才能发动。那只怪兽回到持有者的额外卡组，自己从卡组抽出那个连接标记的数量。那之后，选抽出数量的手卡用喜欢的顺序回到卡组下面。
--[[ __CARD_HEADER_END__ ]]

--バウンドリンク
function c51335426.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TODECK+CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,51335426+EFFECT_COUNT_CODE_OATH)
	e1:SetTarget(c51335426.target)
	e1:SetOperation(c51335426.activate)
	c:RegisterEffect(e1)
end
function c51335426.filter(c,tp)
	return (c:IsLocation(LOCATION_GRAVE) or c:IsFaceup()) and c:IsType(TYPE_LINK) and c:IsAbleToExtra() and Duel.IsPlayerCanDraw(tp,c:GetLink())
end
function c51335426.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE+LOCATION_GRAVE) and chkc:IsControler(tp) and c51335426.filter(chkc,tp) end
	if chk==0 then return Duel.IsExistingTarget(c51335426.filter,tp,LOCATION_MZONE+LOCATION_GRAVE,0,1,nil,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g=Duel.SelectTarget(tp,c51335426.filter,tp,LOCATION_MZONE+LOCATION_GRAVE,0,1,1,nil,tp)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,g,1,0,0)
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(g:GetFirst():GetLink())
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,g:GetFirst():GetLink())
	Duel.SetOperationInfo(0,CATEGORY_TODECK,nil,0,tp,g:GetFirst():GetLink())
end
function c51335426.activate(e,tp,eg,ep,ev,re,r,rp)
	local p=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER)
	local tc=Duel.GetFirstTarget()
	local ct=tc:GetLink()
	if tc:IsRelateToEffect(e) and Duel.SendtoDeck(tc,nil,SEQ_DECKSHUFFLE,REASON_EFFECT)~=0 and tc:IsLocation(LOCATION_EXTRA) then
		if Duel.Draw(p,ct,REASON_EFFECT)==ct then
			local g=Duel.GetMatchingGroup(Card.IsAbleToDeck,p,LOCATION_HAND,0,nil)
			if g:GetCount()<ct then return end
			Duel.ShuffleHand(p)
			Duel.BreakEffect()
			Duel.Hint(HINT_SELECTMSG,p,HINTMSG_TODECK)
			local sg=g:Select(p,ct,ct,nil)
			aux.PlaceCardsOnDeckBottom(p,sg)
		end
	end
end
