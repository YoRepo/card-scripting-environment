--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:49
-- Source DB: cards.cdb
-- Card: DoSolfachord Cutia  (ID: 55226153)
-- Type: Monster / Effect / Pendulum
-- Attribute: EARTH
-- Race: Fairy
-- Level: 1
-- ATK 100 | DEF 400
-- Pendulum Scale: L8 / R8
-- Setcode: 0x162
-- Scope: OCG / TCG
--
-- Effect Text:
-- Pendulum Scale = 8
-- [ Pendulum Effect ]
-- Pendulum Summons of your "Solfachord" Pendulum Monsters cannot be negated.
-- ----------------------------------------
-- [ Monster Effect ]
-- While you have an even Pendulum Scale in your Pendulum Zone, "Solfachord" Pendulum Monsters you
-- control gain ATK equal to 100 x their own Pendulum Scale.
-- If this card is Normal or Special Summoned: You can add 1 "Solfachord" Pendulum Monster from your
-- Deck to your hand, except "DoSolfachord Cutia".
-- You can only use this effect of "DoSolfachord Cutia" once per turn.
--[[ __CARD_HEADER_END__ ]]

--ドドレミコード・キューティア
function c55226153.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c)
	--cannot disable spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_DISABLE_SPSUMMON)
	e1:SetProperty(EFFECT_FLAG_IGNORE_RANGE+EFFECT_FLAG_SET_AVAILABLE)
	e1:SetRange(LOCATION_PZONE)
	e1:SetTarget(c55226153.distg)
	c:RegisterEffect(e1)
	--search
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(55226153,0))
	e2:SetCategory(CATEGORY_SEARCH+CATEGORY_TOHAND)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_SUMMON_SUCCESS)
	e2:SetProperty(EFFECT_FLAG_DELAY)
	e2:SetCountLimit(1,55226153)
	e2:SetTarget(c55226153.srtg)
	e2:SetOperation(c55226153.srop)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e3)
	--atk
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD)
	e4:SetCode(EFFECT_UPDATE_ATTACK)
	e4:SetRange(LOCATION_MZONE)
	e4:SetTargetRange(LOCATION_MZONE,0)
	e4:SetCondition(c55226153.atkcon)
	e4:SetTarget(c55226153.atktg)
	e4:SetValue(c55226153.atkval)
	c:RegisterEffect(e4)
end
function c55226153.distg(e,c)
	return c:IsControler(e:GetHandlerPlayer()) and c:IsSetCard(0x162) and c:IsType(TYPE_PENDULUM) and c:IsSummonType(SUMMON_TYPE_PENDULUM)
end
function c55226153.srfilter(c)
	return not c:IsCode(55226153) and c:IsSetCard(0x162) and c:IsType(TYPE_PENDULUM) and c:IsAbleToHand()
end
function c55226153.srtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c55226153.srfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c55226153.srop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c55226153.srfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
function c55226153.pfilter(c)
	return c:GetCurrentScale()%2==0
end
function c55226153.atkcon(e)
	local tp=e:GetHandlerPlayer()
	return Duel.IsExistingMatchingCard(c55226153.pfilter,tp,LOCATION_PZONE,0,1,nil)
end
function c55226153.atktg(e,c)
	return c:IsSetCard(0x162) and c:IsType(TYPE_PENDULUM)
end
function c55226153.atkval(e,c)
	return c:GetCurrentScale()*100
end
