--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:44
-- Source DB: cards.cdb
-- Card: Prediction Ritual  (ID: 30392583)
-- Type: Spell / Ritual
-- Scope: OCG / TCG
--
-- Effect Text:
-- This card is used to Ritual Summon "Prediction Princess Tarotrei".
-- You must also Tribute monsters from your hand or field whose total Levels equal 9 or more.
-- During your Main Phase, except the turn this card was sent to the GY: You can banish this card from
-- your GY; add 1 "Prediction Princess" monster from your Deck to your hand.
--[[ __CARD_HEADER_END__ ]]

--聖占術の儀式
function c30392583.initial_effect(c)
	aux.AddRitualProcGreaterCode(c,94997874)
	--to hand
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_GRAVE)
	e1:SetCondition(aux.exccon)
	e1:SetCost(aux.bfgcost)
	e1:SetTarget(c30392583.thtg)
	e1:SetOperation(c30392583.thop)
	c:RegisterEffect(e1)
end
function c30392583.thfilter(c)
	return c:IsSetCard(0xcc) and c:IsType(TYPE_MONSTER) and c:IsAbleToHand()
end
function c30392583.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c30392583.thfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c30392583.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c30392583.thfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
