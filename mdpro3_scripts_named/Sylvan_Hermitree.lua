--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:44
-- Source DB: cards.cdb
-- Card: Sylvan Hermitree  (ID: 25824484)
-- Type: Monster / Effect
-- Attribute: FIRE
-- Race: Plant
-- Level: 8
-- ATK 2700 | DEF 1800
-- Setcode: 0x90
-- Scope: OCG / TCG
--
-- Effect Text:
-- Once per turn: You can excavate the top card of your Deck, and if it is a Plant-Type monster, send
-- it to the Graveyard, and if you do, draw 1 card.
-- Otherwise, place it on the bottom of your Deck.
-- If this card is excavated from the Deck and sent to the Graveyard by a card effect: Look at up to 3
-- cards from the top of your Deck, then place them on the top of the Deck in any order.
--[[ __CARD_HEADER_END__ ]]

--森羅の仙樹 レギア
function c25824484.initial_effect(c)
	--deck check
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(25824484,0))
	e1:SetCategory(CATEGORY_DRAW+CATEGORY_DECKDES)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetTarget(c25824484.target)
	e1:SetOperation(c25824484.operation)
	c:RegisterEffect(e1)
	--sort decktop
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(25824484,1))
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_TO_GRAVE)
	e2:SetCondition(c25824484.sdcon)
	e2:SetOperation(c25824484.sdop)
	c:RegisterEffect(e2)
end
function c25824484.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDiscardDeck(tp,1) end
end
function c25824484.operation(e,tp,eg,ep,ev,re,r,rp)
	if not Duel.IsPlayerCanDiscardDeck(tp,1) then return end
	Duel.ConfirmDecktop(tp,1)
	local g=Duel.GetDecktopGroup(tp,1)
	local tc=g:GetFirst()
	if tc:IsRace(RACE_PLANT) then
		Duel.DisableShuffleCheck()
		Duel.SendtoGrave(tc,REASON_EFFECT+REASON_REVEAL)
		Duel.Draw(tp,1,REASON_EFFECT)
	else
		Duel.MoveSequence(tc,SEQ_DECKBOTTOM)
	end
end
function c25824484.sdcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsPreviousLocation(LOCATION_DECK) and c:IsReason(REASON_REVEAL)
end
function c25824484.sdop(e,tp,eg,ep,ev,re,r,rp)
	local ct=Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)
	if ct==0 then return end
	local ac=1
	if ct>1 then
		Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(25824484,2))
		if ct==2 then ac=Duel.AnnounceNumber(tp,1,2)
		else ac=Duel.AnnounceNumber(tp,1,2,3) end
	end
	Duel.SortDecktop(tp,tp,ac)
end
