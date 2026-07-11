--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:44
-- Source DB: cards.cdb
-- Card: Performapal Silver Claw  (ID: 26270847)
-- Type: Monster / Effect / Pendulum
-- Attribute: DARK
-- Race: Beast
-- Level: 4
-- ATK 1800 | DEF 700
-- Pendulum Scale: L5 / R5
-- Setcode: 0x9f
-- Scope: OCG / TCG
--
-- Effect Text:
-- Pendulum Scale = 5
-- [ Pendulum Effect ]
-- All "Performapal" monsters you control gain 300 ATK.
-- ----------------------------------------
-- [ Monster Effect ]
-- When this card declares an attack: All "Performapal" monsters you currently control gain 300 ATK,
-- until the end of the Battle Phase.
--[[ __CARD_HEADER_END__ ]]

--EMシルバー・クロウ
function c26270847.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c)
	--atk
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetRange(LOCATION_PZONE)
	e2:SetTargetRange(LOCATION_MZONE,0)
	e2:SetTarget(c26270847.atktg)
	e2:SetValue(300)
	c:RegisterEffect(e2)
	--atk
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(26270847,0))
	e3:SetCategory(CATEGORY_ATKCHANGE)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e3:SetCode(EVENT_ATTACK_ANNOUNCE)
	e3:SetTarget(c26270847.target)
	e3:SetOperation(c26270847.operation)
	c:RegisterEffect(e3)
end
function c26270847.atktg(e,c)
	return c:IsSetCard(0x9f)
end
function c26270847.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x9f)
end
function c26270847.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c26270847.filter,tp,LOCATION_MZONE,0,1,nil) end
end
function c26270847.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c26270847.filter,tp,LOCATION_MZONE,0,nil)
	local tc=g:GetFirst()
	while tc do
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(300)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_BATTLE)
		tc:RegisterEffect(e1)
		tc=g:GetNext()
	end
end
