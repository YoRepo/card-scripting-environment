--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:50
-- Source DB: cards.cdb
-- Card: Cattycorn  (ID: 61245403)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Plant
-- Level: 4
-- ATK 1500 | DEF 500
-- Scope: OCG / TCG
--
-- Effect Text:
-- If this card is Special Summoned while you control no card in your Field Zone: You can add 1 Field
-- Spell from your Deck to your hand.
-- If this card is destroyed by battle or card effect and sent to the GY: You can target 1 Field Spell
-- in your GY; add 1 card with its name from your Deck to your hand.
-- You can only use each effect of "Cattycorn" once per turn.
--[[ __CARD_HEADER_END__ ]]

--ネコーン
function c61245403.initial_effect(c)
	--Search
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_DELAY+EFFECT_FLAG_ACTIVATE_CONDITION)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCountLimit(1,61245403)
	e1:SetCondition(c61245403.thcon1)
	e1:SetTarget(c61245403.thtg1)
	e1:SetOperation(c61245403.thop1)
	c:RegisterEffect(e1)
	--deck to hand
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_TO_GRAVE)
	e2:SetProperty(EFFECT_FLAG_DELAY+EFFECT_FLAG_CARD_TARGET)
	e2:SetCountLimit(1,61245404)
	e2:SetCondition(c61245403.thcon2)
	e2:SetTarget(c61245403.thtg2)
	e2:SetOperation(c61245403.thop2)
	c:RegisterEffect(e2)
end
function c61245403.thcon1(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetFieldGroupCount(tp,LOCATION_FZONE,0)==0
end
function c61245403.thfilter1(c)
	return c:IsType(TYPE_FIELD) and c:IsAbleToHand()
end
function c61245403.thtg1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c61245403.thfilter1,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c61245403.thop1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local tg=Duel.SelectMatchingCard(tp,c61245403.thfilter1,tp,LOCATION_DECK,0,1,1,nil)
	if tg:GetCount()>0 then
		Duel.SendtoHand(tg,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,tg)
	end
end
function c61245403.thcon2(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsReason(REASON_DESTROY) and c:IsReason(REASON_BATTLE+REASON_EFFECT)
end
function c61245403.thfilter2(c,tp)
	return c:IsType(TYPE_FIELD) and Duel.IsExistingMatchingCard(c61245403.codefilter,tp,LOCATION_DECK,0,1,nil,c)
end
function c61245403.codefilter(c,tc)
	return c:IsCode(tc:GetCode()) and c:IsAbleToHand()
end
function c61245403.thtg2(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c61245403.thfilter2(chkc,tp) end
	if chk==0 then return Duel.IsExistingTarget(c61245403.thfilter2,tp,LOCATION_GRAVE,0,1,nil,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	local g=Duel.SelectTarget(tp,c61245403.thfilter2,tp,LOCATION_GRAVE,0,1,1,nil,tp)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c61245403.thop2(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if not tc:IsRelateToEffect(e) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local tg=Duel.SelectMatchingCard(tp,c61245403.codefilter,tp,LOCATION_DECK,0,1,1,nil,tc)
	if tg:GetCount()>0 then
		Duel.SendtoHand(tg,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,tg)
	end
end
