--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:43
-- Source DB: cards.cdb
-- Card: Oafdragon Magician  (ID: 14920218)
-- Type: Monster / Effect / Pendulum
-- Attribute: WIND
-- Race: Spellcaster
-- Level: 6
-- ATK 2100 | DEF 1400
-- Pendulum Scale: L2 / R2
-- Setcode: 0x98
-- Scope: OCG / TCG
--
-- Effect Text:
-- Pendulum Scale = 2
-- [ Pendulum Effect ]
-- If you have a "Magician" card in your other Pendulum Zone: You can add 1 face-up "Magician" or
-- "Odd-Eyes" Pendulum Monster from your Extra Deck to your hand, except "Oafdragon Magician".
-- You can only use this effect of "Oafdragon Magician" once per turn.
-- ----------------------------------------
-- [ Monster Effect ]
-- If this card is Normal or Special Summoned: You can target 1 "Magician" Pendulum Monster or
-- "Odd-Eyes" monster in your GY, except "Oafdragon Magician"; add it to your hand.
-- You can only use this effect of "Oafdragon Magician" once per turn.
--[[ __CARD_HEADER_END__ ]]

--賤竜の魔術師
function c14920218.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c)
	--to hand
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(14920218,0))
	e2:SetCategory(CATEGORY_TOHAND)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_PZONE)
	e2:SetCountLimit(1,14920218)
	e2:SetCondition(c14920218.pcon)
	e2:SetTarget(c14920218.ptg)
	e2:SetOperation(c14920218.pop)
	c:RegisterEffect(e2)
	--to hand
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(14920218,1))
	e3:SetCategory(CATEGORY_TOHAND)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_SUMMON_SUCCESS)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e3:SetCountLimit(1,14920219)
	e3:SetTarget(c14920218.thtg)
	e3:SetOperation(c14920218.thop)
	c:RegisterEffect(e3)
	local e4=e3:Clone()
	e4:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e4)
end
function c14920218.pcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(Card.IsSetCard,tp,LOCATION_PZONE,0,1,e:GetHandler(),0x98)
end
function c14920218.pfilter(c)
	return c:IsFaceup() and c:IsType(TYPE_PENDULUM) and c:IsSetCard(0x98,0x99) and not c:IsCode(14920218) and c:IsAbleToHand()
end
function c14920218.ptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c14920218.pfilter,tp,LOCATION_EXTRA,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_EXTRA)
end
function c14920218.pop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c14920218.pfilter,tp,LOCATION_EXTRA,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
function c14920218.thfilter(c)
	return c:IsType(TYPE_MONSTER) and ((c:IsSetCard(0x98) and c:IsType(TYPE_PENDULUM)) or c:IsSetCard(0x99)) and not c:IsCode(14920218) and c:IsAbleToHand()
end
function c14920218.thtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c14920218.thfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c14920218.thfilter,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectTarget(tp,c14920218.thfilter,tp,LOCATION_GRAVE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,1,0,0)
end
function c14920218.thop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SendtoHand(tc,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,tc)
	end
end
