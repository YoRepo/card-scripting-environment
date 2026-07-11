--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:44
-- Source DB: cards.cdb
-- Card: Parthian Shot  (ID: 29185231)
-- Type: Trap / Counter
-- Scope: OCG / TCG
--
-- Effect Text:
-- At the end of the Battle Phase: It becomes the End Phase of this turn.
--[[ __CARD_HEADER_END__ ]]

--一撃離脱
function c29185231.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(TIMING_BATTLE_END)
	e1:SetCondition(c29185231.condition)
	e1:SetOperation(c29185231.activate)
	c:RegisterEffect(e1)
end
function c29185231.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetCurrentPhase()==PHASE_BATTLE
end
function c29185231.activate(e,tp,eg,ep,ev,re,r,rp)
	local turnp=Duel.GetTurnPlayer()
	Duel.SkipPhase(turnp,PHASE_BATTLE,RESET_PHASE+PHASE_END,1,1)
	Duel.SkipPhase(turnp,PHASE_MAIN2,RESET_PHASE+PHASE_END,1)
end
