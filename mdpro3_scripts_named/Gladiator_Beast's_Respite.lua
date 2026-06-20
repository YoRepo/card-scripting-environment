--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:37
-- Card: 休息的剑斗兽  (ID: 98891840)
-- Type: Spell
-- ATK 0 | DEF 0
-- Setcode: 4121
--
-- Effect Text:
-- 从自己手卡把2张名字带有「剑斗兽」的卡回到卡组。那之后，从自己卡组抽3张卡。
--[[ __CARD_HEADER_END__ ]]

--休息する剣闘獣
function c98891840.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TODECK+CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c98891840.target)
	e1:SetOperation(c98891840.activate)
	c:RegisterEffect(e1)
end
function c98891840.filter(c)
	return c:IsSetCard(0x1019) and c:IsAbleToDeck()
end
function c98891840.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,3)
		and Duel.IsExistingMatchingCard(c98891840.filter,tp,LOCATION_HAND,0,2,e:GetHandler()) end
	Duel.SetTargetPlayer(tp)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,nil,2,tp,LOCATION_HAND)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,3)
end
function c98891840.activate(e,tp,eg,ep,ev,re,r,rp)
	local p=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER)
	local g=Duel.GetMatchingGroup(c98891840.filter,p,LOCATION_HAND,0,nil)
	if g:GetCount()>=2 then
		Duel.Hint(HINT_SELECTMSG,p,HINTMSG_TODECK)
		local sg=g:Select(p,2,2,nil)
		Duel.ConfirmCards(1-p,sg)
		Duel.SendtoDeck(sg,nil,SEQ_DECKSHUFFLE,REASON_EFFECT)
		Duel.ShuffleDeck(p)
		Duel.BreakEffect()
		Duel.Draw(p,3,REASON_EFFECT)
	end
end
