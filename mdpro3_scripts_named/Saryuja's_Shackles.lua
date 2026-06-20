--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 蛇龙的枷锁  (ID: 11434258)
-- Type: Trap
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 这个卡名的卡在1回合只能发动1张。
-- ①：以对方的场上·墓地1只连接怪兽为对象才能发动。自己从卡组抽出那只怪兽的连接标记的数量。那之后，自己手卡是2张以上的场合，选那之内的2张用喜欢的顺序回到卡组最下面。
--[[ __CARD_HEADER_END__ ]]

--蛇龍の枷鎖
function c11434258.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DRAW)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,11434258+EFFECT_COUNT_CODE_OATH)
	e1:SetTarget(c11434258.drtg)
	e1:SetOperation(c11434258.drop)
	c:RegisterEffect(e1)
end
function c11434258.filter(c,tp)
	return c:IsType(TYPE_LINK) and Duel.IsPlayerCanDraw(tp,c:GetLink())
end
function c11434258.drtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(1-tp) and chkc:IsLocation(LOCATION_MZONE+LOCATION_GRAVE) and c11434258.filter(chkc,tp) end
	if chk==0 then return Duel.IsExistingTarget(c11434258.filter,tp,0,LOCATION_MZONE+LOCATION_GRAVE,1,nil,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	local g=Duel.SelectTarget(tp,c11434258.filter,tp,0,LOCATION_MZONE+LOCATION_GRAVE,1,1,nil,tp)
	local tc=g:GetFirst()
	local ct=tc:GetLink()
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(ct)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,ct)
end
function c11434258.drop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	if Duel.Draw(p,d,REASON_EFFECT)~=0 and Duel.GetFieldGroupCount(p,LOCATION_HAND,0)>1 then
		local g=Duel.GetMatchingGroup(Card.IsAbleToDeck,p,LOCATION_HAND,0,nil)
		if g:GetCount()==0 then return end
		Duel.ShuffleHand(p)
		Duel.BreakEffect()
		Duel.Hint(HINT_SELECTMSG,p,HINTMSG_TODECK)
		local sg=g:Select(p,2,2,nil)
		aux.PlaceCardsOnDeckBottom(p,sg)
	end
end
