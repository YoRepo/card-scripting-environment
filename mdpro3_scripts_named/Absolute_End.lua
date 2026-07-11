--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:44
-- Source DB: cards.cdb
-- Card: Absolute End  (ID: 27744077)
-- Type: Trap
-- Scope: OCG / TCG
--
-- Effect Text:
-- Activate only during your opponent's turn.
-- This turn, the attacks from your opponent's monsters become direct attacks.
--[[ __CARD_HEADER_END__ ]]

--絶体絶命
function c27744077.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMING_BATTLE_START)
	e1:SetCondition(c27744077.condition)
	e1:SetOperation(c27744077.activate)
	c:RegisterEffect(e1)
end
function c27744077.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()~=tp and Duel.GetCurrentPhase()<PHASE_MAIN2
end
function c27744077.activate(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_IGNORE_BATTLE_TARGET)
	e1:SetTargetRange(LOCATION_MZONE,0)
	e1:SetProperty(EFFECT_FLAG_SET_AVAILABLE+EFFECT_FLAG_IGNORE_IMMUNE)
	e1:SetValue(c27744077.imval)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
	local e2=e1:Clone()
	e2:SetProperty(0)
	e2:SetValue(0)
	Duel.RegisterEffect(e2,tp)
	e1:SetLabelObject(e2)
end
function c27744077.imval(e,c)
	return not c:IsImmuneToEffect(e:GetLabelObject())
end
