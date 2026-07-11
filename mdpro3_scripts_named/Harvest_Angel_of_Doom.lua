--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:44
-- Source DB: cards.cdb
-- Card: Harvest Angel of Doom  (ID: 31987203)
-- Type: Monster / Effect / Pendulum
-- Attribute: DARK
-- Race: Fairy
-- Level: 4
-- ATK 1800 | DEF 1000
-- Pendulum Scale: L8 / R8
-- Scope: OCG / TCG
--
-- Effect Text:
-- Pendulum Scale = 8
-- [ Pendulum Effect ]
-- During your Main Phase: You can destroy this card, and if you do, add 1 "Black Horn of Heaven" from
-- your Deck to your hand.
-- You can only use this effect of "Harvest Angel of Doom" once per turn.
-- ----------------------------------------
-- [ Monster Effect ]
-- If this card is Normal or Pendulum Summoned: You can add 1 "Horn of Heaven" from your Deck to your
-- hand.
-- If this card is Tributed: You can place this card in your Pendulum Zone.
-- You can only use each effect of "Harvest Angel of Doom" once per turn.
--[[ __CARD_HEADER_END__ ]]

--死天使ハーヴェスト
function c31987203.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c)
	--black horn of heaven search
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(31987203,0))
	e1:SetCategory(CATEGORY_DESTROY+CATEGORY_SEARCH+CATEGORY_TOHAND)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_PZONE)
	e1:SetCountLimit(1,31987203)
	e1:SetTarget(c31987203.thtg1)
	e1:SetOperation(c31987203.thop1)
	c:RegisterEffect(e1)
	--horn of heaven search
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetProperty(EFFECT_FLAG_DELAY)
	e2:SetCode(EVENT_SUMMON_SUCCESS)
	e2:SetCountLimit(1,31987204)
	e2:SetTarget(c31987203.thtg2)
	e2:SetOperation(c31987203.thop2)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	e3:SetCondition(c31987203.thcon)
	c:RegisterEffect(e3)
	--pzone move
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e4:SetProperty(EFFECT_FLAG_DELAY)
	e4:SetCode(EVENT_RELEASE)
	e4:SetCountLimit(1,31987205)
	e4:SetTarget(c31987203.pentg)
	e4:SetOperation(c31987203.penop)
	c:RegisterEffect(e4)
end
function c31987203.thfilter(c,code)
	return c:IsCode(code) and c:IsAbleToHand()
end
function c31987203.thtg1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c31987203.thfilter,tp,LOCATION_DECK,0,1,nil,50323155) end
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,e:GetHandler(),1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c31987203.thop1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) or Duel.Destroy(c,REASON_EFFECT)==0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c31987203.thfilter,tp,LOCATION_DECK,0,1,1,nil,50323155)
	if #g==0 then return end
	Duel.SendtoHand(g,nil,REASON_EFFECT)
	Duel.ConfirmCards(1-tp,g)
end
function c31987203.thcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsSummonType(SUMMON_TYPE_PENDULUM)
end
function c31987203.thtg2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c31987203.thfilter,tp,LOCATION_DECK,0,1,nil,98069388) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c31987203.thop2(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c31987203.thfilter,tp,LOCATION_DECK,0,1,1,nil,98069388)
	if #g==0 then return end
	Duel.SendtoHand(g,nil,REASON_EFFECT)
	Duel.ConfirmCards(1-tp,g)
end
function c31987203.pentg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLocation(tp,LOCATION_PZONE,0) or Duel.CheckLocation(tp,LOCATION_PZONE,1) end
end
function c31987203.penop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		Duel.MoveToField(c,tp,tp,LOCATION_PZONE,POS_FACEUP,true)
	end
end
