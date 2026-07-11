--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:48
-- Source DB: cards.cdb
-- Card: Abyss Actor - Wild Hope  (ID: 51391183)
-- Type: Monster / Effect / Pendulum
-- Attribute: DARK
-- Race: Fiend
-- Level: 4
-- ATK 1600 | DEF 1200
-- Pendulum Scale: L2 / R2
-- Setcode: 0x10ec
-- Scope: OCG / TCG
--
-- Effect Text:
-- Pendulum Scale = 2
-- [ Pendulum Effect ]
-- Once per turn: You can target 1 "Abyss Actor" card in your other Pendulum Zone; its Pendulum Scale
-- becomes 9 until the end of this turn, also you cannot Special Summon monsters for the rest of this
-- turn, except "Abyss Actor" monsters (even if this card leaves the field).
-- ----------------------------------------
-- [ Monster Effect ]
-- Once per turn: You can make this card gain 100 ATK for each "Abyss Actor" monster you currently
-- control with different names, until the end of this turn.
-- If this card is destroyed by battle or card effect: You can add 1 "Abyss Actor" card from your Deck
-- to your hand, except "Abyss Actor - Wild Hope".
-- You can only use this effect of "Abyss Actor - Wild Hope" once per turn.
--[[ __CARD_HEADER_END__ ]]

--魔界劇団－ワイルド・ホープ
function c51391183.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c)
	--scale
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(51391183,0))
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_PZONE)
	e1:SetCountLimit(1)
	e1:SetTarget(c51391183.target)
	e1:SetOperation(c51391183.operation)
	c:RegisterEffect(e1)
	--atk up
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_ATKCHANGE)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetTarget(c51391183.atktg)
	e2:SetOperation(c51391183.atkop)
	c:RegisterEffect(e2)
	--to hand
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetProperty(EFFECT_FLAG_DELAY)
	e3:SetCode(EVENT_DESTROYED)
	e3:SetCountLimit(1,51391183)
	e3:SetCondition(c51391183.thcon)
	e3:SetTarget(c51391183.thtg)
	e3:SetOperation(c51391183.thop)
	c:RegisterEffect(e3)
end
function c51391183.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	if chk==0 then return Duel.IsExistingTarget(Card.IsSetCard,tp,LOCATION_PZONE,0,1,e:GetHandler(),0x10ec) end
	local tc=Duel.GetFirstMatchingCard(Card.IsSetCard,tp,LOCATION_PZONE,0,e:GetHandler(),0x10ec)
	Duel.SetTargetCard(tc)
end
function c51391183.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CHANGE_LSCALE)
		e1:SetValue(9)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
		local e2=e1:Clone()
		e2:SetCode(EFFECT_CHANGE_RSCALE)
		tc:RegisterEffect(e2)
	end
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e3:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e3:SetTargetRange(1,0)
	e3:SetTarget(c51391183.splimit)
	e3:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e3,tp)
end
function c51391183.splimit(e,c)
	return not c:IsSetCard(0x10ec)
end
function c51391183.atkfilter(c)
	return c:IsSetCard(0x10ec) and c:IsFaceup()
end
function c51391183.atktg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c51391183.atkfilter,tp,LOCATION_MZONE,0,1,nil) end
end
function c51391183.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local g=Duel.GetMatchingGroup(c51391183.atkfilter,tp,LOCATION_MZONE,0,nil)
	if c:IsFaceup() and c:IsRelateToEffect(e) then
		local atkval=g:GetClassCount(Card.GetCode)*100
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(atkval)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		c:RegisterEffect(e1)
	end
end
function c51391183.thcon(e,tp,eg,ep,ev,re,r,rp)
	return bit.band(r,REASON_EFFECT+REASON_BATTLE)~=0
end
function c51391183.filter(c)
	return c:IsSetCard(0x10ec) and c:IsAbleToHand() and not c:IsCode(51391183)
end
function c51391183.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c51391183.filter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c51391183.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c51391183.filter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
