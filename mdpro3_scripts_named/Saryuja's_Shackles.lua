--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:42
-- Source DB: cards.cdb
-- Card: Saryuja's Shackles  (ID: 11434258)
-- Type: Trap
-- Scope: OCG / TCG
--
-- Effect Text:
-- Target 1 Link Monster your opponent controls or is in their GY; draw cards equal to its Link Rating,
-- then, if you have 2 or more cards in your hand, place 2 cards from your hand on the bottom of your
-- Deck in any order.
-- You can only activate 1 "Saryuja's Shackles" per turn.
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
