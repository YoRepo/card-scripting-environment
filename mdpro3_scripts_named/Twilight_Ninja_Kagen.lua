--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:51
-- Source DB: cards.cdb
-- Card: Twilight Ninja Kagen  (ID: 6830480)
-- Type: Monster / Effect / Pendulum
-- Attribute: DARK
-- Race: Warrior
-- Level: 1
-- ATK 0 | DEF 2000
-- Pendulum Scale: L10 / R10
-- Setcode: 0x2b
-- Scope: OCG / TCG
--
-- Effect Text:
-- Pendulum Scale = 10
-- [ Pendulum Effect ]
-- You cannot Pendulum Summon monsters, except "Ninja" monsters.
-- This effect cannot be negated.
-- Once per turn, when your "Ninja" monster declares an attack: You can make that monster gain 1000 ATK
-- until the end of the Damage Step (even if this card leaves the field).
-- ----------------------------------------
-- [ Monster Effect ]
-- You can Tribute this card, then target 1 "Ninja" monster you control; it gains 800 ATK until the end
-- of this turn.
--[[ __CARD_HEADER_END__ ]]

--黄昏の忍者－カゲン
function c6830480.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c)
	--splimit
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetRange(LOCATION_PZONE)
	e1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetTargetRange(1,0)
	e1:SetTarget(c6830480.splimit)
	c:RegisterEffect(e1)
	--atk
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(6830480,0))
	e2:SetCategory(CATEGORY_ATKCHANGE)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_ATTACK_ANNOUNCE)
	e2:SetRange(LOCATION_PZONE)
	e2:SetCountLimit(1)
	e2:SetCondition(c6830480.atkcon)
	e2:SetOperation(c6830480.atkop)
	c:RegisterEffect(e2)
	--gain atk
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(6830480,1))
	e3:SetCategory(CATEGORY_ATKCHANGE)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCost(c6830480.cost)
	e3:SetTarget(c6830480.tg)
	e3:SetOperation(c6830480.op)
	c:RegisterEffect(e3)
end
function c6830480.splimit(e,c,tp,sumtp,sumpos)
	return not c:IsSetCard(0x2b) and bit.band(sumtp,SUMMON_TYPE_PENDULUM)==SUMMON_TYPE_PENDULUM
end
function c6830480.atkcon(e,tp,eg,ep,ev,re,r,rp)
	local at=Duel.GetAttacker()
	return at:IsControler(tp) and at:IsSetCard(0x2b)
end
function c6830480.atkop(e,tp,eg,ep,ev,re,r,rp)
	local at=Duel.GetAttacker()
	if at:IsFaceup() and at:IsRelateToBattle() then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(1000)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_DAMAGE)
		at:RegisterEffect(e1)
	end
end
function c6830480.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsReleasable() end
	Duel.Release(e:GetHandler(),REASON_COST)
end
function c6830480.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x2b)
end
function c6830480.tg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_MZONE) and c6830480.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c6830480.filter,tp,LOCATION_MZONE,0,1,e:GetHandler()) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,c6830480.filter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c6830480.op(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsFaceup() and tc:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		e1:SetValue(800)
		tc:RegisterEffect(e1)
	end
end
