--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:45
-- Source DB: cards.cdb
-- Card: Photon Leo  (ID: 38757297)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Beast
-- Level: 6
-- ATK 2100 | DEF 1100
-- Setcode: 0x55
-- Scope: OCG / TCG
--
-- Effect Text:
-- When this card is Normal Summoned: You can have your opponent shuffle their entire hand into the
-- Deck, then they draw the same number of cards as they shuffled into the Deck.
--[[ __CARD_HEADER_END__ ]]

--フォトン・レオ
function c38757297.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(38757297,0))
	e1:SetCategory(CATEGORY_TODECK+CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetTarget(c38757297.target)
	e1:SetOperation(c38757297.activate)
	c:RegisterEffect(e1)
end
function c38757297.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(1-tp)
		and Duel.IsExistingMatchingCard(Card.IsAbleToDeck,tp,0,LOCATION_HAND,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TODECK,nil,1,1-tp,LOCATION_HAND)
end
function c38757297.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetFieldGroup(tp,0,LOCATION_HAND)
	if g:GetCount()==0 then return end
	Duel.SendtoDeck(g,nil,SEQ_DECKSHUFFLE,REASON_EFFECT)
	Duel.ShuffleDeck(1-tp)
	Duel.BreakEffect()
	Duel.Draw(1-tp,g:GetCount(),REASON_EFFECT)
end
