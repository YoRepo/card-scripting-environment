--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:47
-- Source DB: cards.cdb
-- Card: Sylvan Snapdrassinagon  (ID: 47741109)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Plant
-- Level: 1
-- ATK 900 | DEF 400
-- Setcode: 0x90
-- Scope: OCG / TCG
--
-- Effect Text:
-- If this card is sent from the field or the hand to the Graveyard: You can excavate the top card of
-- your Deck, and if it is a Plant-Type monster, send it to the Graveyard.
-- Otherwise, place it on the bottom of your Deck.
-- If this card is excavated from the Deck and sent to the Graveyard by a card effect: You can excavate
-- the top card of your Deck, and if it is a Plant-Type monster, send it to the Graveyard.
-- Otherwise, place it on the bottom of your Deck.
--[[ __CARD_HEADER_END__ ]]

--森羅の隠蜜 スナッフ
function c47741109.initial_effect(c)
	--tograve
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(47741109,0))
	e1:SetCategory(CATEGORY_DECKDES)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_TO_GRAVE)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetCondition(c47741109.condition)
	e1:SetTarget(c47741109.target)
	e1:SetOperation(c47741109.operation)
	c:RegisterEffect(e1)
end
function c47741109.condition(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsPreviousLocation(LOCATION_HAND+LOCATION_ONFIELD) or (c:IsPreviousLocation(LOCATION_DECK) and	c:IsReason(REASON_REVEAL))
end
function c47741109.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDiscardDeck(tp,1) end
end
function c47741109.operation(e,tp,eg,ep,ev,re,r,rp)
	if not Duel.IsPlayerCanDiscardDeck(tp,1) then return end
	Duel.ConfirmDecktop(tp,1)
	local g=Duel.GetDecktopGroup(tp,1)
	local tc=g:GetFirst()
	if tc:IsRace(RACE_PLANT) then
		Duel.DisableShuffleCheck()
		Duel.SendtoGrave(g,REASON_EFFECT+REASON_REVEAL)
	else
		Duel.MoveSequence(tc,SEQ_DECKBOTTOM)
	end
end
