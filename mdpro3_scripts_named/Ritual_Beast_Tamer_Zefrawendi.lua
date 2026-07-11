--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:43
-- Source DB: cards.cdb
-- Card: Ritual Beast Tamer Zefrawendi  (ID: 23166823)
-- Type: Monster / Effect / Pendulum
-- Attribute: WIND
-- Race: Psychic
-- Level: 3
-- ATK 1500 | DEF 1000
-- Pendulum Scale: L7 / R7
-- Setcode: 0xc4, 0x10b5
-- Scope: OCG / TCG
--
-- Effect Text:
-- Pendulum Scale = 7
-- [ Pendulum Effect ]
-- You cannot Pendulum Summon monsters, except "Ritual Beast" and "Zefra" monsters.
-- This effect cannot be negated.
-- ----------------------------------------
-- [ Monster Effect ]
-- When this card is Normal or Pendulum Summoned: You can add 1 face-up "Zefra" monster from your Extra
-- Deck to your hand, except "Ritual Beast Tamer Zefrawendi".
-- You can only Special Summon "Ritual Beast Tamer Zefrawendi(s)" once per turn.
--[[ __CARD_HEADER_END__ ]]

--影霊獣使い－セフィラウェンディ
function c23166823.initial_effect(c)
	c:SetSPSummonOnce(23166823)
	--pendulum summon
	aux.EnablePendulumAttribute(c)
	--splimit
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetRange(LOCATION_PZONE)
	e2:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_CAN_FORBIDDEN)
	e2:SetTargetRange(1,0)
	e2:SetTarget(c23166823.splimit)
	c:RegisterEffect(e2)
	--to hand
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_TOHAND)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_SUMMON_SUCCESS)
	e3:SetTarget(c23166823.thtg)
	e3:SetOperation(c23166823.thop)
	c:RegisterEffect(e3)
	local e4=e3:Clone()
	e4:SetCode(EVENT_SPSUMMON_SUCCESS)
	e4:SetCondition(c23166823.condition)
	c:RegisterEffect(e4)
end
function c23166823.splimit(e,c,sump,sumtype,sumpos,targetp)
	if c:IsSetCard(0xb5,0xc4) then return false end
	return bit.band(sumtype,SUMMON_TYPE_PENDULUM)==SUMMON_TYPE_PENDULUM
end
function c23166823.condition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsSummonType(SUMMON_TYPE_PENDULUM)
end
function c23166823.filter(c)
	return c:IsFaceup() and c:IsSetCard(0xc4) and c:IsType(TYPE_PENDULUM) and not c:IsCode(23166823) and c:IsAbleToHand()
end
function c23166823.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c23166823.filter,tp,LOCATION_EXTRA,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_EXTRA)
end
function c23166823.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c23166823.filter,tp,LOCATION_EXTRA,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
