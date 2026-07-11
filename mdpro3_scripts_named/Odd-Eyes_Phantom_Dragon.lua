--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:53
-- Source DB: cards.cdb
-- Card: Odd-Eyes Phantom Dragon  (ID: 93149655)
-- Type: Monster / Effect / Pendulum
-- Attribute: DARK
-- Race: Dragon
-- Level: 7
-- ATK 2500 | DEF 2000
-- Pendulum Scale: L4 / R4
-- Setcode: 0x99
-- Scope: OCG / TCG
--
-- Effect Text:
-- Pendulum Scale = 4
-- [ Pendulum Effect ]
-- Once per turn, when an attack is declared involving your face-up monster and an opponent's monster,
-- if you have an "Odd-Eyes" card in your other Pendulum Zone: You can make that monster you control
-- gain 1200 ATK until the end of the Battle Phase (even if this card leaves the field).
-- ----------------------------------------
-- [ Monster Effect ]
-- When this Pendulum Summoned card inflicts battle damage to your opponent by attacking: You can
-- inflict damage to your opponent equal to the number of "Odd-Eyes" cards in your Pendulum Zones x
-- 1200.
-- You can only use this effect of "Odd-Eyes Phantom Dragon" once per turn.
--[[ __CARD_HEADER_END__ ]]

--オッドアイズ・ファントム・ドラゴン
function c93149655.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c)
	--atk up
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(93149655,0))
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetRange(LOCATION_PZONE)
	e1:SetCountLimit(1)
	e1:SetCondition(c93149655.atkcon)
	e1:SetTarget(c93149655.atktg)
	e1:SetOperation(c93149655.atkop)
	c:RegisterEffect(e1)
	--damage
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(93149655,1))
	e2:SetCategory(CATEGORY_DAMAGE)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_BATTLE_DAMAGE)
	e2:SetCountLimit(1,93149655)
	e2:SetCondition(c93149655.damcon)
	e2:SetTarget(c93149655.damtg)
	e2:SetOperation(c93149655.damop)
	c:RegisterEffect(e2)
end
function c93149655.atkcon(e,tp,eg,ep,ev,re,r,rp)
	if not Duel.IsExistingMatchingCard(Card.IsSetCard,tp,LOCATION_PZONE,0,1,e:GetHandler(),0x99) then return end
	local a=Duel.GetAttacker()
	local d=Duel.GetAttackTarget()
	if d and a:GetControler()~=d:GetControler() then
		if a:IsControler(tp) and a:IsFaceup() then e:SetLabelObject(a)
		elseif d:IsFaceup() then e:SetLabelObject(d)
		else return false end
		return true
	else return false end
end
function c93149655.atktg(e,tp,eg,ep,ev,re,r,rp,chk)
	local tc=e:GetLabelObject()
	if chk==0 then return tc:IsOnField() end
	Duel.SetTargetCard(tc)
end
function c93149655.atkop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() and tc:IsControler(tp) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(1200)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_BATTLE)
		tc:RegisterEffect(e1)
	end
end
function c93149655.damcon(e,tp,eg,ep,ev,re,r,rp)
	return ep~=tp and e:GetHandler():IsSummonType(SUMMON_TYPE_PENDULUM)
		and Duel.GetAttacker()==e:GetHandler()
end
function c93149655.damfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x99)
end
function c93149655.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
	local ct=Duel.GetMatchingGroupCount(c93149655.damfilter,tp,LOCATION_PZONE,0,nil)
	if chk==0 then return ct>0 end
	Duel.SetTargetParam(ct*1200)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,ct*1200)
end
function c93149655.damop(e,tp,eg,ep,ev,re,r,rp)
	local ct=Duel.GetMatchingGroupCount(c93149655.damfilter,tp,LOCATION_PZONE,0,nil)
	Duel.Damage(1-tp,ct*1200,REASON_EFFECT)
end
