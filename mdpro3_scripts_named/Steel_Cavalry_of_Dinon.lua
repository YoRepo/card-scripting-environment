--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:44
-- Source DB: cards.cdb
-- Card: Steel Cavalry of Dinon  (ID: 2396042)
-- Type: Monster / Effect / Pendulum
-- Attribute: EARTH
-- Race: Dinosaur
-- Level: 4
-- ATK 1600 | DEF 2600
-- Pendulum Scale: L5 / R5
-- Scope: OCG / TCG
--
-- Effect Text:
-- Pendulum Scale = 5
-- ----------------------------------------
-- [ Monster Effect ]
-- At the start of the Damage Step, if this card battles a Pendulum Monster: This card's ATK and DEF
-- become half its current ATK and DEF until the end of the Damage Step.
--[[ __CARD_HEADER_END__ ]]

--ディノンの鋼鉄騎兵
function c2396042.initial_effect(c)
	aux.EnablePendulumAttribute(c)
	--atk/def
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(2396042,0))
	e1:SetCategory(CATEGORY_ATKCHANGE+CATEGORY_DEFCHANGE)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_BATTLE_START)
	e1:SetCondition(c2396042.adcon)
	e1:SetOperation(c2396042.adop)
	c:RegisterEffect(e1)
end
function c2396042.adcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local bc=c:GetBattleTarget()
	return bc and bc:IsFaceup() and bc:IsType(TYPE_PENDULUM)
end
function c2396042.adop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and c:IsFaceup() then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_DEFENSE_FINAL)
		e1:SetValue(math.ceil(c:GetDefense()/2))
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_DISABLE+RESET_PHASE+PHASE_DAMAGE)
		c:RegisterEffect(e1)
		local e2=e1:Clone()
		e2:SetCode(EFFECT_SET_ATTACK_FINAL)
		e2:SetValue(math.ceil(c:GetAttack()/2))
		c:RegisterEffect(e2)
	end
end
