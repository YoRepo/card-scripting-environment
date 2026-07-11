--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:42
-- Source DB: cards.cdb
-- Card: Performapal Odd-Eyes Minitaurus  (ID: 10731333)
-- Type: Monster / Effect / Pendulum
-- Attribute: DARK
-- Race: Beast-Warrior
-- Level: 4
-- ATK 1200 | DEF 1600
-- Pendulum Scale: L6 / R6
-- Setcode: 0x9f, 0x99
-- Scope: OCG / TCG
--
-- Effect Text:
-- Pendulum Scale = 6
-- [ Pendulum Effect ]
-- If your "Performapal" or "Odd-Eyes" monster attacks a Defense Position monster, inflict piercing
-- battle damage to your opponent.
-- ----------------------------------------
-- [ Monster Effect ]
-- During damage calculation, if your Pendulum Monster attacks an opponent's monster: You can make that
-- opponent's monster lose 100 ATK for each "Performapal" and "Odd-Eyes" card you control, during
-- damage calculation only.
--[[ __CARD_HEADER_END__ ]]

--EMオッドアイズ・ミノタウロス
function c10731333.initial_effect(c)
	aux.EnablePendulumAttribute(c)
	--pierce
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_PIERCE)
	e1:SetRange(LOCATION_PZONE)
	e1:SetTargetRange(LOCATION_MZONE,0)
	e1:SetTarget(c10731333.ptg)
	c:RegisterEffect(e1)
	--atk down
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_ATKCHANGE)
	e2:SetType(EFFECT_TYPE_TRIGGER_O+EFFECT_TYPE_FIELD)
	e2:SetCode(EVENT_PRE_DAMAGE_CALCULATE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCondition(c10731333.atkcon)
	e2:SetOperation(c10731333.atkop)
	c:RegisterEffect(e2)
end
function c10731333.ptg(e,c)
	return c:IsSetCard(0x9f,0x99)
end
function c10731333.atkfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x9f,0x99)
end
function c10731333.atkcon(e,tp,eg,ep,ev,re,r,rp)
	local a=Duel.GetAttacker()
	local d=a:GetBattleTarget()
	local gc=Duel.GetMatchingGroupCount(c10731333.atkfilter,tp,LOCATION_ONFIELD,0,nil)
	return a:IsControler(tp) and a:IsType(TYPE_PENDULUM) and d
		and d:IsFaceup() and not d:IsControler(tp) and gc>0
end
function c10731333.atkop(e,tp,eg,ep,ev,re,r,rp)
	local d=Duel.GetAttacker():GetBattleTarget()
	local gc=Duel.GetMatchingGroupCount(c10731333.atkfilter,tp,LOCATION_ONFIELD,0,nil)
	if d:IsRelateToBattle() and d:IsFaceup() then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_DAMAGE_CAL)
		e1:SetValue(-gc*100)
		d:RegisterEffect(e1)
	end
end
