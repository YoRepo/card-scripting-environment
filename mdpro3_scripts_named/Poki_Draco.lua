--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:52
-- Source DB: cards.cdb
-- Card: Poki Draco  (ID: 8175346)
-- Type: Monster / Effect
-- Attribute: FIRE
-- Race: Dragon
-- Level: 3
-- ATK 200 | DEF 100
-- Scope: OCG / TCG
--
-- Effect Text:
-- When this card is Normal Summoned: You can add 1 "Poki Draco" from your Deck to your hand.
--[[ __CARD_HEADER_END__ ]]

--ポケ・ドラ
function c8175346.initial_effect(c)
	--search
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(8175346,0))
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_TRIGGER_O+EFFECT_TYPE_SINGLE)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetTarget(c8175346.target)
	e1:SetOperation(c8175346.operation)
	c:RegisterEffect(e1)
end
function c8175346.filter(c)
	return c:IsCode(8175346) and c:IsAbleToHand()
end
function c8175346.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c8175346.filter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c8175346.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstMatchingCard(c8175346.filter,tp,LOCATION_DECK,0,nil)
	if tc then
		Duel.SendtoHand(tc,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,tc)
	end
end
