--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:53
-- Source DB: cards.cdb
-- Card: Samurai Cavalry of Reptier  (ID: 93124273)
-- Type: Monster / Effect / Pendulum
-- Attribute: EARTH
-- Race: Dinosaur
-- Level: 4
-- ATK 1800 | DEF 1200
-- Pendulum Scale: L3 / R3
-- Scope: OCG / TCG
--
-- Effect Text:
-- Pendulum Scale = 3
-- ----------------------------------------
-- [ Monster Effect ]
-- At the start of the Damage Step, if this card attacks an opponent's face-up monster that is not a
-- Pendulum Monster: You can destroy that monster.
--[[ __CARD_HEADER_END__ ]]

--レプティアの武者騎兵
function c93124273.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c)
	--destroy
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(93124273,0))
	e2:SetCategory(CATEGORY_DESTROY)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_BATTLE_START)
	e2:SetTarget(c93124273.target)
	e2:SetOperation(c93124273.operation)
	c:RegisterEffect(e2)
end
function c93124273.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local d=Duel.GetAttackTarget()
	if chk==0 then return Duel.GetAttacker()==e:GetHandler()
		and d and d:IsFaceup() and not d:IsType(TYPE_PENDULUM) end
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,d,1,0,0)
end
function c93124273.operation(e,tp,eg,ep,ev,re,r,rp)
	local d=Duel.GetAttackTarget()
	if d:IsRelateToBattle() then
		Duel.Destroy(d,REASON_EFFECT)
	end
end
