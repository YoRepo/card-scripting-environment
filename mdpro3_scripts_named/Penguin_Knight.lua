--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:45
-- Source DB: cards.cdb
-- Card: Penguin Knight  (ID: 36039163)
-- Type: Monster / Effect
-- Attribute: WATER
-- Race: Aqua
-- Level: 3
-- ATK 900 | DEF 800
-- Setcode: 0x5a
-- Scope: OCG / TCG
--
-- Effect Text:
-- When this card is sent directly from your Deck to the Graveyard by an effect of a card controlled by
-- your opponent, unite your Graveyard cards and your own Deck, shuffle them and form a new Deck.
--[[ __CARD_HEADER_END__ ]]

--ペンギン・ナイト
function c36039163.initial_effect(c)
	--to deck
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(36039163,0))
	e1:SetCategory(CATEGORY_TODECK)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_TO_GRAVE)
	e1:SetCondition(c36039163.tdcon)
	e1:SetTarget(c36039163.tdtg)
	e1:SetOperation(c36039163.tdop)
	c:RegisterEffect(e1)
end
function c36039163.tdcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsPreviousLocation(LOCATION_DECK) and bit.band(r,REASON_EFFECT)~=0 and rp==1-tp
end
function c36039163.tdtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local g=Duel.GetFieldGroup(tp,LOCATION_GRAVE,0)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,g,g:GetCount(),0,0)
end
function c36039163.tdop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetFieldGroup(tp,LOCATION_GRAVE,0)
	if aux.NecroValleyNegateCheck(g) then return end
	if Duel.SendtoDeck(g,nil,SEQ_DECKSHUFFLE,REASON_EFFECT)~=0 then
		if g:IsExists(Card.IsLocation,1,nil,LOCATION_DECK) then Duel.ShuffleDeck(tp) end
	end
end
