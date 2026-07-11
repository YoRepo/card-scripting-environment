--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:45
-- Source DB: cards.cdb
-- Card: Fluffal Dog  (ID: 39246582)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Fairy
-- Level: 4
-- ATK 1700 | DEF 1000
-- Setcode: 0xa9
-- Scope: OCG / TCG
--
-- Effect Text:
-- When this card is Normal or Special Summoned from the hand: You can add 1 "Edge Imp Sabres" or 1
-- "Fluffal" monster from your Deck to your hand, except "Fluffal Dog".
-- You can only use this effect of "Fluffal Dog" once per turn.
--[[ __CARD_HEADER_END__ ]]

--ファーニマル・ドッグ
function c39246582.initial_effect(c)
	--search
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(39246582,0))
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e1:SetCountLimit(1,39246582)
	e1:SetCondition(c39246582.thcon)
	e1:SetTarget(c39246582.thtg)
	e1:SetOperation(c39246582.thop)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e2)
end
function c39246582.thcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsPreviousLocation(LOCATION_HAND)
end
function c39246582.filter(c)
	return (c:IsCode(30068120) or (c:IsSetCard(0xa9) and c:IsType(TYPE_MONSTER) and not c:IsCode(39246582)))
		and c:IsAbleToHand()
end
function c39246582.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c39246582.filter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c39246582.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c39246582.filter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
