--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 同归于尽  (ID: 14057297)
-- Type: Trap
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 这个卡名的卡在1回合只能发动1张。
-- ①：双方手卡各自是3张以上的场合才能发动。双方玩家各自让手卡全部用喜欢的顺序回到卡组下面，自己失去这个效果让双方回到卡组的卡数量×300基本分。那之后，双方玩家各自从卡组抽5张。
--[[ __CARD_HEADER_END__ ]]

--死なばもろとも
function c14057297.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TODECK+CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,14057297+EFFECT_COUNT_CODE_OATH)
	e1:SetCondition(c14057297.condition)
	e1:SetTarget(c14057297.target)
	e1:SetOperation(c14057297.activate)
	c:RegisterEffect(e1)
end
function c14057297.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetFieldGroupCount(tp,LOCATION_HAND,0)>=3 and Duel.GetFieldGroupCount(tp,0,LOCATION_HAND)>=3
end
function c14057297.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,5) and Duel.IsPlayerCanDraw(1-tp,5) end
	local g=Duel.GetFieldGroup(tp,LOCATION_HAND,LOCATION_HAND)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,g,g:GetCount(),0,0)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,PLAYER_ALL,5)
end
function c14057297.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetFieldGroupCount(tp,LOCATION_HAND,LOCATION_HAND)==0 then return end
	local p=tp
	local st=0
	for i=1,2 do
		local sg=Duel.GetFieldGroup(p,LOCATION_HAND,0)
		Duel.SendtoDeck(sg,nil,SEQ_DECKTOP,REASON_EFFECT)
		local og=Duel.GetOperatedGroup()
		local ct=og:FilterCount(Card.IsLocation,nil,LOCATION_DECK)
		if ct>0 then
			st=st+ct
			Duel.SortDecktop(p,p,ct)
			for j=1,ct do
				local mg=Duel.GetDecktopGroup(p,1)
				Duel.MoveSequence(mg:GetFirst(),SEQ_DECKBOTTOM)
			end
		end
		p=1-p
	end
	local lp=Duel.GetLP(tp)
	Duel.SetLP(tp,lp-st*300)
	if Duel.GetLP(tp)>0 then
		Duel.BreakEffect()
		Duel.Draw(tp,5,REASON_EFFECT)
		Duel.Draw(1-tp,5,REASON_EFFECT)
	end
end
