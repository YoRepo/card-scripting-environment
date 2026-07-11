--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:43
-- Source DB: cards.cdb
-- Card: Gishki Mollusk  (ID: 19959742)
-- Type: Monster / Effect
-- Attribute: WATER
-- Race: Aqua
-- Level: 4
-- ATK 1700 | DEF 900
-- Setcode: 0x3a
-- Scope: OCG / TCG
--
-- Effect Text:
-- When this card is sent to the Graveyard by a card effect: Look at the top 3 cards of your Deck, then
-- return them all to the top or to the bottom of the Deck, in any order.
--[[ __CARD_HEADER_END__ ]]

--リチュア・シェルフィッシュ
function c19959742.initial_effect(c)
	--confirm
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(19959742,0))
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_TO_GRAVE)
	e1:SetCondition(c19959742.condition)
	e1:SetOperation(c19959742.operation)
	c:RegisterEffect(e1)
end
function c19959742.condition(e,tp,eg,ep,ev,re,r,rp)
	return bit.band(r,REASON_EFFECT)~=0 and Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)>=3
end
function c19959742.operation(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)<3 then return end
	Duel.SortDecktop(tp,tp,3)
	if Duel.SelectOption(tp,aux.Stringid(19959742,1),aux.Stringid(19959742,2))==1 then
		for i=1,3 do
			local mg=Duel.GetDecktopGroup(tp,1)
			Duel.MoveSequence(mg:GetFirst(),SEQ_DECKBOTTOM)
		end
	end
end
