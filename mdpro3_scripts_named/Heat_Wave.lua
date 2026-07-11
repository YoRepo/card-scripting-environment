--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:46
-- Source DB: cards.cdb
-- Card: Heat Wave  (ID: 45141013)
-- Type: Spell
-- Scope: OCG / TCG
--
-- Effect Text:
-- At the start of your Main Phase 1: Neither player can Normal or Special Summon Effect Monsters,
-- until your next Draw Phase.
--[[ __CARD_HEADER_END__ ]]

--大熱波
function c45141013.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c45141013.condition)
	e1:SetOperation(c45141013.operation)
	c:RegisterEffect(e1)
end
function c45141013.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetCurrentPhase()==PHASE_MAIN1 and not Duel.CheckPhaseActivity()
end
function c45141013.operation(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTargetRange(1,1)
	e1:SetTarget(c45141013.sumlimit)
	e1:SetReset(RESET_PHASE+PHASE_END,2)
	Duel.RegisterEffect(e1,tp)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_CANNOT_SUMMON)
	Duel.RegisterEffect(e2,tp)
end
function c45141013.sumlimit(e,c,sump,sumtype,sumpos,targetp)
	return c:GetOriginalType()&TYPE_EFFECT>0 and sumtype~=SUMMON_TYPE_DUAL
end
