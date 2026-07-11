--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:53
-- Source DB: cards.cdb
-- Card: Flashbang  (ID: 9267769)
-- Type: Trap
-- Scope: OCG / TCG
--
-- Effect Text:
-- Activate only after damage calculation when a monster your opponent controls made a direct attack.
-- It is now the End Phase of this turn.
--[[ __CARD_HEADER_END__ ]]

--閃光弾
function c9267769.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_BATTLE_DAMAGE)
	e1:SetCondition(c9267769.condition)
	e1:SetOperation(c9267769.activate)
	c:RegisterEffect(e1)
end
function c9267769.condition(e,tp,eg,ep,ev,re,r,rp)
	return eg:GetFirst():IsControler(1-tp) and Duel.GetAttackTarget()==nil
end
function c9267769.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.SkipPhase(1-tp,PHASE_BATTLE,RESET_PHASE+PHASE_END,1,1)
	Duel.SkipPhase(1-tp,PHASE_MAIN2,RESET_PHASE+PHASE_END,1)
end
