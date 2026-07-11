--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:43
-- Source DB: cards.cdb
-- Card: Performapal Monkeyboard  (ID: 17330916)
-- Type: Monster / Effect / Pendulum
-- Attribute: EARTH
-- Race: Beast
-- Level: 6
-- ATK 1000 | DEF 2400
-- Pendulum Scale: L1 / R1
-- Setcode: 0x9f
-- Scope: OCG / TCG
--
-- Effect Text:
-- Pendulum Scale = 1
-- [ Pendulum Effect ]
-- Unless you have a "Performapal" card in your other Pendulum Zone, this card's Pendulum Scale becomes
-- 4.
-- During your Main Phase, if this card was activated this turn: You can add 1 Level 4 or lower
-- "Performapal" monster from your Deck to your hand.
-- You can only use this effect of "Performapal Monkeyboard" once per turn.
-- ----------------------------------------
-- [ Monster Effect ]
-- You can discard this card; reveal 1 "Performapal" or "Odd-Eyes" monster in your hand, and if you do,
-- reduce the Levels of monsters in your hand with that name by 1 for the rest of this turn (even after
-- they are Summoned/Set).
--[[ __CARD_HEADER_END__ ]]

--EMモンキーボード
function c17330916.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c,false)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(1160)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetRange(LOCATION_HAND)
	e1:SetCost(c17330916.reg)
	c:RegisterEffect(e1)
	--scale
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_CHANGE_LSCALE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_PZONE)
	e2:SetCondition(c17330916.sccon)
	e2:SetValue(4)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EFFECT_CHANGE_RSCALE)
	c:RegisterEffect(e3)
	--lvdown
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(17330916,0))
	e4:SetType(EFFECT_TYPE_IGNITION)
	e4:SetRange(LOCATION_HAND)
	e4:SetCountLimit(1)
	e4:SetCost(c17330916.lvcost)
	e4:SetTarget(c17330916.lvtg)
	e4:SetOperation(c17330916.lvop)
	c:RegisterEffect(e4)
	--to hand
	local e5=Effect.CreateEffect(c)
	e5:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e5:SetType(EFFECT_TYPE_IGNITION)
	e5:SetRange(LOCATION_PZONE)
	e5:SetCountLimit(1,17330916)
	e5:SetCondition(c17330916.thcon)
	e5:SetTarget(c17330916.thtg)
	e5:SetOperation(c17330916.thop)
	c:RegisterEffect(e5)
end
function c17330916.sccon(e)
	return not Duel.IsExistingMatchingCard(Card.IsSetCard,e:GetHandlerPlayer(),LOCATION_PZONE,0,1,e:GetHandler(),0x9f)
end
function c17330916.reg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	e:GetHandler():RegisterFlagEffect(17330916,RESET_PHASE+PHASE_END,EFFECT_FLAG_OATH,1)
end
function c17330916.thcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetFlagEffect(17330916)~=0
end
function c17330916.thfilter(c)
	return c:IsLevelBelow(4) and c:IsSetCard(0x9f) and c:IsAbleToHand()
end
function c17330916.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c17330916.thfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c17330916.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c17330916.thfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
function c17330916.lvcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsDiscardable() end
	Duel.SendtoGrave(e:GetHandler(),REASON_DISCARD)
end
function c17330916.filter(c)
	return c:IsSetCard(0x9f,0x99) and c:IsType(TYPE_MONSTER) and c:IsLevelAbove(2)
end
function c17330916.lvtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c17330916.filter,tp,LOCATION_HAND,0,1,e:GetHandler()) end
end
function c17330916.afilter(c,code)
	return c:IsCode(code)
end
function c17330916.lvop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONFIRM)
	local g=Duel.SelectMatchingCard(tp,c17330916.filter,tp,LOCATION_HAND,0,1,1,nil)
	Duel.ConfirmCards(1-tp,g)
	Duel.ShuffleHand(tp)
	local hg=Duel.GetMatchingGroup(c17330916.afilter,tp,LOCATION_HAND,0,nil,g:GetFirst():GetCode())
	local tc=hg:GetFirst()
	while tc do
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_LEVEL)
		e1:SetValue(-1)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD-RESET_TOFIELD+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
		tc=hg:GetNext()
	end
end
