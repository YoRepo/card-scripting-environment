--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:43
-- Source DB: cards.cdb
-- Card: Crystal Keeper  (ID: 14469229)
-- Type: Monster / Effect / Pendulum
-- Attribute: FIRE
-- Race: Warrior
-- Level: 4
-- ATK 1500 | DEF 1800
-- Pendulum Scale: L2 / R2
-- Setcode: 0x34
-- Scope: OCG / TCG
--
-- Effect Text:
-- Pendulum Scale = 2
-- [ Pendulum Effect ]
-- Each turn, the first time an "Ultimate Crystal" monster(s) and/or "Crystal Beast" card(s) you
-- control would be destroyed by card effect that turn, it is not destroyed.
-- ----------------------------------------
-- [ Monster Effect ]
-- If a "Crystal Beast" monster you control battles an opponent's monster, during damage calculation
-- (Quick Effect): You can Tribute this card from your hand or face-up field; your battling monster's
-- ATK/DEF become double its original ATK/DEF during that damage calculation only, but it is destroyed
-- at the end of this Damage Step.
--[[ __CARD_HEADER_END__ ]]

--宝玉の守護者
function c14469229.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c)
	--replace
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_INDESTRUCTABLE_COUNT)
	e2:SetRange(LOCATION_PZONE)
	e2:SetTargetRange(LOCATION_ONFIELD,0)
	e2:SetCountLimit(1)
	e2:SetTarget(c14469229.indtg)
	e2:SetValue(c14469229.indval)
	c:RegisterEffect(e2)
	--double
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(14469229,0))
	e3:SetType(EFFECT_TYPE_QUICK_O)
	e3:SetCode(EVENT_PRE_DAMAGE_CALCULATE)
	e3:SetRange(LOCATION_MZONE+LOCATION_HAND)
	e3:SetCost(c14469229.cost)
	e3:SetTarget(c14469229.target)
	e3:SetOperation(c14469229.operation)
	c:RegisterEffect(e3)
end
function c14469229.indtg(e,c)
	return c:IsSetCard(0x1034) or (c:IsLocation(LOCATION_MZONE) and c:IsSetCard(0x2034))
end
function c14469229.indval(e,re,r,rp)
	return bit.band(r,REASON_EFFECT)~=0
end
function c14469229.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsReleasable() end
	Duel.Release(e:GetHandler(),REASON_COST)
end
function c14469229.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local a=Duel.GetAttacker()
	local d=Duel.GetAttackTarget()
	if a:IsControler(1-tp) then a=d end
	if chk==0 then return d and a:IsSetCard(0x1034) end
	e:SetLabelObject(a)
end
function c14469229.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetLabelObject()
	if tc:IsRelateToBattle() and tc:IsFaceup() then
		local atk=tc:GetBaseAttack()
		local def=tc:GetBaseDefense()
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_ATTACK_FINAL)
		e1:SetValue(atk*2)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_DAMAGE_CAL)
		tc:RegisterEffect(e1)
		local e2=e1:Clone()
		e2:SetCode(EFFECT_SET_DEFENSE_FINAL)
		e2:SetValue(def*2)
		tc:RegisterEffect(e2)
		local e3=Effect.CreateEffect(e:GetHandler())
		e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
		e3:SetCode(EVENT_DAMAGE_STEP_END)
		e3:SetOperation(c14469229.desop)
		e3:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_DAMAGE)
		tc:RegisterEffect(e3)
	end
end
function c14469229.desop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToBattle() and c:IsFaceup() then
		Duel.Destroy(c,REASON_EFFECT)
	end
end
