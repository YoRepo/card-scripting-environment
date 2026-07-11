--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:48
-- Source DB: cards.cdb
-- Card: Heavy Slump  (ID: 52417194)
-- Type: Trap
-- Scope: OCG / TCG
--
-- Effect Text:
-- If your opponent has 8 or more cards in their hand: They shuffle their entire hand into the Deck,
-- then draw 2 cards.
--[[ __CARD_HEADER_END__ ]]

--大暴落
function c52417194.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TODECK+CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetHintTiming(0,TIMING_TOHAND)
	e1:SetCondition(c52417194.condition)
	e1:SetTarget(c52417194.target)
	e1:SetOperation(c52417194.activate)
	c:RegisterEffect(e1)
end
function c52417194.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetFieldGroupCount(tp,0,LOCATION_HAND)>7
end
function c52417194.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(1-tp) end
	Duel.SetTargetPlayer(1-tp)
end
function c52417194.activate(e,tp,eg,ep,ev,re,r,rp)
	local p=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER)
	local g=Duel.GetFieldGroup(p,LOCATION_HAND,0)
	Duel.SendtoDeck(g,nil,SEQ_DECKSHUFFLE,REASON_EFFECT)
	Duel.ShuffleDeck(p)
	Duel.BreakEffect()
	Duel.Draw(p,2,REASON_EFFECT)
end
