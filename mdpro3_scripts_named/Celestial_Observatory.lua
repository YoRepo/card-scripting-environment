--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:51
-- Source DB: cards.cdb
-- Card: Celestial Observatory  (ID: 67378104)
-- Type: Spell
-- Scope: OCG / TCG
--
-- Effect Text:
-- Place 1 Level 6 monster from your hand or face-up field on the bottom of the Deck; draw 2 cards.
-- You can only activate 1 "Celestial Observatory" per turn.
--[[ __CARD_HEADER_END__ ]]

--星呼びの天儀台
function c67378104.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,67378104+EFFECT_COUNT_CODE_OATH)
	e1:SetCost(c67378104.cost)
	e1:SetTarget(c67378104.target)
	e1:SetOperation(c67378104.activate)
	c:RegisterEffect(e1)
end
function c67378104.filter(c)
	return c:IsLevel(6) and (c:IsFaceup() or not c:IsLocation(LOCATION_MZONE)) and c:IsAbleToDeckAsCost()
end
function c67378104.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c67378104.filter,tp,LOCATION_HAND+LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g=Duel.SelectMatchingCard(tp,c67378104.filter,tp,LOCATION_HAND+LOCATION_MZONE,0,1,1,nil)
	Duel.ConfirmCards(1-tp,g)
	Duel.SendtoDeck(g,nil,SEQ_DECKBOTTOM,REASON_COST)
end
function c67378104.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,2) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(2)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,2)
end
function c67378104.activate(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
end
