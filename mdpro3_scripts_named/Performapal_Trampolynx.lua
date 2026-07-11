--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:46
-- Source DB: cards.cdb
-- Card: Performapal Trampolynx  (ID: 43241495)
-- Type: Monster / Effect / Pendulum
-- Attribute: EARTH
-- Race: Beast
-- Level: 2
-- ATK 300 | DEF 300
-- Pendulum Scale: L4 / R4
-- Setcode: 0x9f
-- Scope: OCG / TCG
--
-- Effect Text:
-- Pendulum Scale = 4
-- [ Pendulum Effect ]
-- When you Pendulum Summon a monster(s): You can target 1 card in either player's Pendulum Zone;
-- return it to the hand.
-- You can only use this effect of "Performapal Trampolynx" once per turn.
-- ----------------------------------------
-- [ Monster Effect ]
-- When this card is Normal Summoned: You can target 1 card in either player's Pendulum Zone; return it
-- to the hand.
--[[ __CARD_HEADER_END__ ]]

--EMトランポリンクス
function c43241495.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c)
	--tohand
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(43241495,0))
	e2:SetCategory(CATEGORY_TOHAND)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetRange(LOCATION_PZONE)
	e2:SetCountLimit(1,43241495)
	e2:SetCondition(c43241495.thcon)
	e2:SetTarget(c43241495.thtg)
	e2:SetOperation(c43241495.thop1)
	c:RegisterEffect(e2)
	--tohand
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(43241495,1))
	e3:SetCategory(CATEGORY_TOHAND)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_SUMMON_SUCCESS)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetTarget(c43241495.thtg)
	e3:SetOperation(c43241495.thop2)
	c:RegisterEffect(e3)
end
function c43241495.cfilter(c,tp)
	return c:IsSummonPlayer(tp) and c:IsSummonType(SUMMON_TYPE_PENDULUM)
end
function c43241495.thcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c43241495.cfilter,1,nil,tp)
end
function c43241495.filter(c)
	return c:IsAbleToHand()
end
function c43241495.thtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_PZONE) and c43241495.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c43241495.filter,tp,LOCATION_PZONE,LOCATION_PZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RTOHAND)
	local g=Duel.SelectTarget(tp,c43241495.filter,tp,LOCATION_PZONE,LOCATION_PZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,1,0,0)
end
function c43241495.thop1(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SendtoHand(tc,nil,REASON_EFFECT)
	end
end
function c43241495.thop2(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SendtoHand(tc,nil,REASON_EFFECT)
	end
end
