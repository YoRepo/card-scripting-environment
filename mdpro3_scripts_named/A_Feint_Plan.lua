--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:51
-- Source DB: cards.cdb
-- Card: A Feint Plan  (ID: 68170903)
-- Type: Trap
-- Scope: OCG / TCG
--
-- Effect Text:
-- Monsters cannot attack face-down monsters this turn.
--[[ __CARD_HEADER_END__ ]]

--陽動作戦
function c68170903.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMING_BATTLE_START)
	e1:SetCondition(aux.bpcon)
	e1:SetOperation(c68170903.activate)
	c:RegisterEffect(e1)
end
function c68170903.activate(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_SELECT_BATTLE_TARGET)
	e1:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e1:SetValue(c68170903.atlimit)
	e1:SetReset(RESET_PHASE+PHASE_END,1)
	Duel.RegisterEffect(e1,tp)
end
function c68170903.atlimit(e,c)
	return c:IsFacedown()
end
