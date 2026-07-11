--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:49
-- Source DB: cards.cdb
-- Card: Thunder Dragondark  (ID: 56713174)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Thunder
-- Level: 5
-- ATK 1600 | DEF 1500
-- Setcode: 0x11c
-- Scope: OCG / TCG
--
-- Effect Text:
-- (Quick Effect): You can discard this card; add 1 "Thunder Dragondark" from your Deck to your hand.
-- If this card is banished, or sent from the field to the GY: You can add 1 "Thunder Dragon" card from
-- your Deck to your hand, except "Thunder Dragondark".
-- You can only use 1 "Thunder Dragondark" effect per turn, and only once that turn.
--[[ __CARD_HEADER_END__ ]]

--雷電龍－サンダー・ドラゴン
function c56713174.initial_effect(c)
	--search itself
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(56713174,0))
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(TIMING_END_PHASE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,56713174)
	e1:SetCost(c56713174.cost)
	e1:SetTarget(c56713174.target)
	e1:SetOperation(c56713174.operation)
	c:RegisterEffect(e1)
	c56713174.discard_effect=e1
	--search thunder dragon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(56713174,1))
	e2:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_REMOVE)
	e2:SetProperty(EFFECT_FLAG_DELAY)
	e2:SetCountLimit(1,56713174)
	e2:SetTarget(c56713174.thtg)
	e2:SetOperation(c56713174.thop)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EVENT_TO_GRAVE)
	e3:SetCondition(c56713174.thcon)
	c:RegisterEffect(e3)
end
function c56713174.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsDiscardable() end
	Duel.SendtoGrave(e:GetHandler(),REASON_COST+REASON_DISCARD)
end
function c56713174.filter(c)
	return c:IsCode(56713174) and c:IsAbleToHand()
end
function c56713174.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c56713174.filter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c56713174.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c56713174.filter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
function c56713174.thcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsPreviousLocation(LOCATION_ONFIELD)
end
function c56713174.thfilter(c)
	return c:IsSetCard(0x11c) and not c:IsCode(56713174) and c:IsAbleToHand()
end
function c56713174.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c56713174.thfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c56713174.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c56713174.thfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
