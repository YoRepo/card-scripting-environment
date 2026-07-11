--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:53
-- Source DB: cards.cdb
-- Card: Performapal Barracuda  (ID: 92767273)
-- Type: Monster / Effect / Pendulum
-- Attribute: EARTH
-- Race: Plant
-- Level: 3
-- ATK 500 | DEF 1100
-- Pendulum Scale: L5 / R5
-- Setcode: 0x9f
-- Scope: OCG / TCG
--
-- Effect Text:
-- Pendulum Scale = 5
-- [ Pendulum Effect ]
-- Once per turn, if your "Performapal" monster battles an opponent's monster, before damage
-- calculation: You can make that opponent's monster lose ATK equal to the difference between its
-- original ATK and current ATK (even if this card leaves the field).
-- ----------------------------------------
-- [ Monster Effect ]
-- During either player's turn: You can target 1 "Performapal" monster whose current ATK is different
-- from its original ATK; it gains ATK equal to the difference until the end of this turn.
-- You can only use this effect of "Performapal Barracuda" once per turn.
--[[ __CARD_HEADER_END__ ]]

--EMバラクーダ
function c92767273.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c)
	--atk up
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(92767273,0))
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_BATTLE_CONFIRM)
	e1:SetRange(LOCATION_PZONE)
	e1:SetCountLimit(1)
	e1:SetCondition(c92767273.atkcon1)
	e1:SetOperation(c92767273.atkop1)
	c:RegisterEffect(e1)
	--atk down
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(92767273,1))
	e2:SetCategory(CATEGORY_ATKCHANGE)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DAMAGE_STEP)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1,92767273)
	e2:SetCondition(aux.dscon)
	e2:SetTarget(c92767273.atktg2)
	e2:SetOperation(c92767273.atkop2)
	c:RegisterEffect(e2)
end
function c92767273.atkcon1(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetAttacker()
	local bc=Duel.GetAttackTarget()
	if not bc then return false end
	if tc:IsControler(1-tp) then bc,tc=tc,bc end
	e:SetLabelObject(bc)
	return bc:IsFaceup() and tc:IsFaceup() and tc:IsSetCard(0x9f) and bc:GetBaseAttack()~=bc:GetAttack()
end
function c92767273.atkop1(e,tp,eg,ep,ev,re,r,rp)
	local bc=e:GetLabelObject()
	if bc:IsRelateToBattle() and bc:IsFaceup() and bc:IsControler(1-tp) then
		local diff=math.abs(bc:GetBaseAttack()-bc:GetAttack())
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(-diff)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		bc:RegisterEffect(e1)
	end
end
function c92767273.atkfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x9f) and c:GetBaseAttack()~=c:GetAttack()
end
function c92767273.atktg2(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c92767273.atkfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c92767273.atkfilter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.SelectTarget(tp,c92767273.atkfilter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c92767273.atkop2(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() then
		local diff=math.abs(tc:GetBaseAttack()-tc:GetAttack())
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(diff)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
	end
end
