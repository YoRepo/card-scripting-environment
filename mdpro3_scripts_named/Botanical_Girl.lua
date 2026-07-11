--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:52
-- Source DB: cards.cdb
-- Card: Botanical Girl  (ID: 84824601)
-- Type: Monster / Effect
-- Attribute: WATER
-- Race: Plant
-- Level: 3
-- ATK 1300 | DEF 1100
-- Scope: OCG / TCG
--
-- Effect Text:
-- When this card is sent from the field to the Graveyard, you can add 1 Plant-Type monster with 1000
-- or less DEF from your Deck to your hand.
--[[ __CARD_HEADER_END__ ]]

--ボタニティ・ガール
function c84824601.initial_effect(c)
	--search
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(84824601,0))
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e1:SetCode(EVENT_TO_GRAVE)
	e1:SetCondition(c84824601.condition)
	e1:SetTarget(c84824601.target)
	e1:SetOperation(c84824601.operation)
	c:RegisterEffect(e1)
end
function c84824601.condition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsPreviousLocation(LOCATION_ONFIELD)
end
function c84824601.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c84824601.filter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c84824601.filter(c)
	return c:IsDefenseBelow(1000) and c:IsRace(RACE_PLANT) and c:IsAbleToHand()
end
function c84824601.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c84824601.filter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
