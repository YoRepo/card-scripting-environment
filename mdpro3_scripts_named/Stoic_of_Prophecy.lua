--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:49
-- Source DB: cards.cdb
-- Card: Stoic of Prophecy  (ID: 54359696)
-- Type: Monster / Effect
-- Attribute: WATER
-- Race: Spellcaster
-- Level: 1
-- ATK 300 | DEF 200
-- Setcode: 0x6e
-- Scope: OCG / TCG
--
-- Effect Text:
-- When this card is sent to the Graveyard: Add 1 Level 3 "Prophecy" monster from your Deck to your
-- hand.
--[[ __CARD_HEADER_END__ ]]

--魔導術士 ラパンデ
function c54359696.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(54359696,0))
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_TO_GRAVE)
	e1:SetTarget(c54359696.target)
	e1:SetOperation(c54359696.operation)
	c:RegisterEffect(e1)
end
function c54359696.filter(c)
	return c:IsSetCard(0x6e) and c:IsLevel(3) and c:IsAbleToHand()
end
function c54359696.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c54359696.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c54359696.filter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
