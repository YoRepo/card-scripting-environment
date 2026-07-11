--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:52
-- Source DB: cards.cdb
-- Card: The White Stone of Legend  (ID: 79814787)
-- Type: Monster / Effect / Tuner
-- Attribute: LIGHT
-- Race: Dragon
-- Level: 1
-- ATK 300 | DEF 250
-- Scope: OCG / TCG
--
-- Effect Text:
-- If this card is sent to the GY: Add 1 "Blue-Eyes White Dragon" from your Deck to your hand.
--[[ __CARD_HEADER_END__ ]]

--伝説の白石
function c79814787.initial_effect(c)
	aux.AddCodeList(c,89631139)
	--to hand
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(79814787,0))
	e1:SetCategory(CATEGORY_SEARCH+CATEGORY_TOHAND)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_TO_GRAVE)
	e1:SetTarget(c79814787.target)
	e1:SetOperation(c79814787.operation)
	c:RegisterEffect(e1)
end
function c79814787.filter(c)
	return c:IsCode(89631139) and c:IsAbleToHand()
end
function c79814787.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c79814787.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local tc=Duel.GetFirstMatchingCard(c79814787.filter,tp,LOCATION_DECK,0,nil)
	if tc~=nil then
		Duel.SendtoHand(tc,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,tc)
	end
end
