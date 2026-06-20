--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 一时炮固定式  (ID: 70916046)
-- Type: Trap
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 这个卡名的卡在1回合只能发动1张。
-- ①：自己·对方的战斗阶段，宣言1·2·3·4·5·6的其中任意数字才能发动。选对方场上1只效果怪兽，以下数值的合计数字和自己墓地的卡数量相同的场合，把最多有宣言的数字数量的卡从自己卡组上面送去墓地，选
-- 最多有送去墓地的数量的对方场上的卡回到持有者卡组。不是的场合，自己失去宣言的数字×500基本分。
-- ●选的怪兽的等级×宣言的数字
-- ●对方场上的卡数量
--[[ __CARD_HEADER_END__ ]]

--壱時砲固定式
function c70916046.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DECKDES+CATEGORY_TODECK)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,70916046+EFFECT_COUNT_CODE_OATH)
	e1:SetCondition(c70916046.condition)
	e1:SetTarget(c70916046.target)
	e1:SetOperation(c70916046.activate)
	c:RegisterEffect(e1)
end
function c70916046.condition(e,tp,eg,ep,ev,re,r,rp)
	local ph=Duel.GetCurrentPhase()
	return ph>=PHASE_BATTLE_START and ph<=PHASE_BATTLE
end
function c70916046.filter(c)
	return c:IsFaceup() and c:IsType(TYPE_EFFECT) and c:IsLevelAbove(1)
end
function c70916046.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c70916046.filter,tp,0,LOCATION_MZONE,1,nil) and Duel.GetFieldGroupCount(tp,0,LOCATION_ONFIELD)>0 end
	local t={}
	local i=1
	for i=1,6 do t[i]=i end
	e:SetLabel(Duel.AnnounceNumber(tp,table.unpack(t)))
	local g=Duel.GetMatchingGroup(Card.IsAbleToDeck,tp,0,LOCATION_ONFIELD,nil)
	Duel.SetOperationInfo(0,CATEGORY_DECKDES,nil,0,tp,0)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,g,0,0,0)
end
function c70916046.activate(e,tp,eg,ep,ev,re,r,rp)
	--Set up the equation
	local dnum=e:GetLabel()
	local fnum=Duel.GetFieldGroupCount(tp,0,LOCATION_ONFIELD)
	local gnum=Duel.GetFieldGroupCount(tp,LOCATION_GRAVE,0)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	local dg=Duel.SelectMatchingCard(tp,c70916046.filter,tp,0,LOCATION_MZONE,1,1,nil)
	if #dg==0 then return end
	local mon=dg:GetFirst()
	local lnum=mon:GetLevel()
	--The equation
	if ((lnum*dnum)+fnum)==gnum then
		--Select number of cards to send from Deck to GY
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
		local dcount=Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)
		local t={}
		local i=1
		if dcount<=dnum then
			for i=1,dcount do t[i]=i end
		else
			for i=1,dnum do t[i]=i end
		end
		local snum=Duel.AnnounceNumber(tp,table.unpack(t))
		if Duel.DiscardDeck(tp,snum,REASON_EFFECT)~=0 then
			local og=Duel.GetOperatedGroup()
			local tdnum=og:FilterCount(Card.IsLocation,nil,LOCATION_GRAVE)
			local tdg=Duel.GetMatchingGroup(Card.IsAbleToDeck,tp,0,LOCATION_ONFIELD,nil)
			if tdnum<=0 or #tdg<=0 then return end
			--Shuffle opponent's cards into Deck
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
			local rg=tdg:Select(tp,1,tdnum,nil)
			Duel.HintSelection(rg)
			Duel.SendtoDeck(rg,nil,SEQ_DECKSHUFFLE,REASON_EFFECT)
		end
	else
		--Lose LP
		Duel.SetLP(tp,Duel.GetLP(tp)-dnum*500)
	end
end
