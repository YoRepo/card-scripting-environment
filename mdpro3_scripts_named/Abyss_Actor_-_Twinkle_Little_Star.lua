--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:51
-- Source DB: cards.cdb
-- Card: Abyss Actor - Twinkle Little Star  (ID: 7279373)
-- Type: Monster / Effect / Pendulum
-- Attribute: DARK
-- Race: Fiend
-- Level: 4
-- ATK 1000 | DEF 1000
-- Pendulum Scale: L9 / R9
-- Setcode: 0x10ec
-- Scope: OCG / TCG
--
-- Effect Text:
-- Pendulum Scale = 9
-- [ Pendulum Effect ]
-- You cannot Pendulum Summon monsters, except "Abyss Actor" monsters.
-- This effect cannot be negated.
-- Once per turn: You can target 1 "Abyss Actor" monster you control; this turn, it can make up to 3
-- attacks on monsters during each Battle Phase, also other monsters you control cannot attack for the
-- rest of this turn (even if this card leaves the field).
-- ----------------------------------------
-- [ Monster Effect ]
-- Cannot be destroyed by battle during your turn.
-- This card can make up to 3 attacks on monsters during each Battle Phase.
--[[ __CARD_HEADER_END__ ]]

--魔界劇団－ティンクル・リトルスター
function c7279373.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c)
	--splimit
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_CAN_FORBIDDEN)
	e1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e1:SetRange(LOCATION_PZONE)
	e1:SetTargetRange(1,0)
	e1:SetTarget(c7279373.splimit)
	c:RegisterEffect(e1)
	--attack thrice
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(7279373,0))
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetRange(LOCATION_PZONE)
	e2:SetCountLimit(1)
	e2:SetCondition(c7279373.atkcon)
	e2:SetTarget(c7279373.atktg)
	e2:SetOperation(c7279373.atkop)
	c:RegisterEffect(e2)
	--attack thrice
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e3:SetCode(EFFECT_EXTRA_ATTACK_MONSTER)
	e3:SetRange(LOCATION_MZONE)
	e3:SetValue(2)
	c:RegisterEffect(e3)
	--indes
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e4:SetCondition(c7279373.indcon)
	e4:SetValue(1)
	c:RegisterEffect(e4)
end
function c7279373.splimit(e,c,tp,sumtp,sumpos)
	return not c:IsSetCard(0x10ec) and bit.band(sumtp,SUMMON_TYPE_PENDULUM)==SUMMON_TYPE_PENDULUM
end
function c7279373.atkcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsAbleToEnterBP()
end
function c7279373.atkfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x10ec)
end
function c7279373.atktg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c7279373.atkfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c7279373.atkfilter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c7279373.atkfilter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c7279373.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_EXTRA_ATTACK_MONSTER)
		e1:SetValue(2)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
	end
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_CANNOT_ATTACK)
	e2:SetTargetRange(LOCATION_MZONE,0)
	e2:SetTarget(c7279373.ftarget)
	e2:SetLabel(tc:GetFieldID())
	e2:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e2,tp)
end
function c7279373.ftarget(e,c)
	return e:GetLabel()~=c:GetFieldID()
end
function c7279373.indcon(e)
	return Duel.GetTurnPlayer()==e:GetHandlerPlayer()
end
