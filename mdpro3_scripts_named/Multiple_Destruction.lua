--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:43
-- Source DB: cards.cdb
-- Card: Multiple Destruction  (ID: 14057297)
-- Type: Trap
-- Scope: OCG / TCG
--
-- Effect Text:
-- If both players have 3 or more cards in their hand: Each player places their entire hand on the
-- bottom of the Deck in any order, also you lose LP equal to the total number of cards returned to the
-- Deck by this effect x 300 (min. 1), then each player draws 5 cards.
-- You can only activate 1 "Multiple Destruction" per turn.
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
