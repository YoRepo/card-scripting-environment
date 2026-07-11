--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:53
-- Source DB: cards.cdb
-- Card: SPYRAL Master Plan  (ID: 91258852)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Spellcaster
-- Level: 7
-- ATK 1200 | DEF 2800
-- Setcode: 0xee
-- Scope: OCG / TCG
--
-- Effect Text:
-- Once per turn: You can add 1 "SPYRAL MISSION" card from your Deck to your hand.
-- If this card is sent from the field to the GY: You can add 1 "SPYRAL Resort" and 1 "SPYRAL" monster
-- from your Deck to your hand, except "SPYRAL Master Plan".
-- You can only use this effect of "SPYRAL Master Plan" once per turn.
--[[ __CARD_HEADER_END__ ]]

--SPYRAL－グレース
function c91258852.initial_effect(c)
	aux.AddCodeList(c,54631665)
	--search
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(91258852,0))
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetTarget(c91258852.thtg1)
	e1:SetOperation(c91258852.thop1)
	c:RegisterEffect(e1)
	--to hand
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(91258852,1))
	e2:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetProperty(EFFECT_FLAG_DELAY)
	e2:SetCode(EVENT_TO_GRAVE)
	e2:SetCountLimit(1,91258852)
	e2:SetCondition(c91258852.thcon2)
	e2:SetTarget(c91258852.thtg2)
	e2:SetOperation(c91258852.thop2)
	c:RegisterEffect(e2)
end
function c91258852.thfilter1(c)
	return c:IsSetCard(0x20ee) and c:IsAbleToHand()
end
function c91258852.thtg1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c91258852.thfilter1,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c91258852.thop1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c91258852.thfilter1,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
function c91258852.thcon2(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsPreviousLocation(LOCATION_ONFIELD)
end
function c91258852.thfilter2(c,tp)
	return c:IsCode(54631665) and c:IsAbleToHand()
		and Duel.IsExistingMatchingCard(c91258852.thfilter3,tp,LOCATION_DECK,0,1,c)
end
function c91258852.thfilter3(c)
	return c:IsSetCard(0xee) and c:IsType(TYPE_MONSTER) and not c:IsCode(91258852) and c:IsAbleToHand()
end
function c91258852.thtg2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c91258852.thfilter2,tp,LOCATION_DECK,0,1,nil,tp) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c91258852.thop2(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g1=Duel.SelectMatchingCard(tp,c91258852.thfilter2,tp,LOCATION_DECK,0,1,1,nil,tp)
	if g1:GetCount()>0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
		local g2=Duel.SelectMatchingCard(tp,c91258852.thfilter3,tp,LOCATION_DECK,0,1,1,g1:GetFirst())
		g1:Merge(g2)
		Duel.SendtoHand(g1,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g1)
	end
end
