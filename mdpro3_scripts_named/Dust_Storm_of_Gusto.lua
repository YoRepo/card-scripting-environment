--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:52
-- Source DB: cards.cdb
-- Card: Dust Storm of Gusto  (ID: 8414337)
-- Type: Trap
-- Setcode: 0x10
-- Scope: OCG / TCG
--
-- Effect Text:
-- Your opponent cannot activate cards or effects when "Gusto" monsters you control declare their
-- attacks this turn.
--[[ __CARD_HEADER_END__ ]]

--ガスタの風塵
function c8414337.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c8414337.condition)
	e1:SetTarget(c8414337.target)
	e1:SetOperation(c8414337.activate)
	c:RegisterEffect(e1)
end
function c8414337.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp and Duel.GetCurrentPhase()<=PHASE_BATTLE
end
function c8414337.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:IsHasType(EFFECT_TYPE_ACTIVATE) end
end
function c8414337.activate(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EFFECT_CANNOT_ACTIVATE)
	e1:SetTargetRange(0,1)
	e1:SetCondition(c8414337.actcon)
	e1:SetValue(1)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
function c8414337.actcon(e)
	return Duel.CheckEvent(EVENT_ATTACK_ANNOUNCE) and Duel.GetAttacker():IsSetCard(0x10)
end
