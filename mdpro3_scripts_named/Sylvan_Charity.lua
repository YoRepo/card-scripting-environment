--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:52
-- Source DB: cards.cdb
-- Card: Sylvan Charity  (ID: 82016179)
-- Type: Spell
-- Setcode: 0x90
-- Scope: OCG / TCG
--
-- Effect Text:
-- Draw 3 cards, then, if you have a "Sylvan" card in your hand, reveal 2 cards from your hand
-- including at least 1 "Sylvan" card, then place them on the top of the Deck in any order.
-- Otherwise, reveal your entire hand, then place it on the top of the Deck in any order.
-- You can only activate 1 "Sylvan Charity" per turn.
--[[ __CARD_HEADER_END__ ]]

--森羅の施し
function c82016179.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DRAW+CATEGORY_TODECK)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,82016179+EFFECT_COUNT_CODE_OATH)
	e1:SetTarget(c82016179.target)
	e1:SetOperation(c82016179.activate)
	c:RegisterEffect(e1)
end
function c82016179.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,3) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(3)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,3)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,nil,0,tp,2)
end
function c82016179.activate(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	if Duel.Draw(p,d,REASON_EFFECT)==3 then
		Duel.ShuffleHand(p)
		Duel.BreakEffect()
		local g=Duel.GetMatchingGroup(Card.IsAbleToDeck,p,LOCATION_HAND,0,nil)
		if g:GetCount()>1 and g:IsExists(Card.IsSetCard,1,nil,0x90) then
			Duel.Hint(HINT_SELECTMSG,p,HINTMSG_TODECK)
			local sg1=g:FilterSelect(p,Card.IsSetCard,1,1,nil,0x90)
			Duel.Hint(HINT_SELECTMSG,p,HINTMSG_TODECK)
			local sg2=g:Select(p,1,1,sg1:GetFirst())
			sg1:Merge(sg2)
			Duel.ConfirmCards(1-p,sg1)
			aux.PlaceCardsOnDeckTop(p,sg1)
		else
			local hg=Duel.GetFieldGroup(p,LOCATION_HAND,0)
			Duel.ConfirmCards(1-p,hg)
			aux.PlaceCardsOnDeckTop(p,hg)
		end
	end
end
