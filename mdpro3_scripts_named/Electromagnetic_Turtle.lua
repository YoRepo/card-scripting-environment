--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:45
-- Source DB: cards.cdb
-- Card: Electromagnetic Turtle  (ID: 34710660)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Machine
-- Level: 4
-- ATK 0 | DEF 1800
-- Scope: OCG / TCG
--
-- Effect Text:
-- During your opponent's Battle Phase (Quick Effect): You can banish this card from your GY; end the
-- Battle Phase.
-- You can only use this effect of "Electromagnetic Turtle" once per Duel.
--[[ __CARD_HEADER_END__ ]]

--超電磁タートル
function c34710660.initial_effect(c)
	--end battle phase
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(34710660,0))
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetRange(LOCATION_GRAVE)
	e1:SetCountLimit(1,34710660+EFFECT_COUNT_CODE_DUEL)
	e1:SetCondition(c34710660.condition)
	e1:SetCost(aux.bfgcost)
	e1:SetOperation(c34710660.operation)
	c:RegisterEffect(e1)
end
function c34710660.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()~=tp and (Duel.GetCurrentPhase()>=PHASE_BATTLE_START and Duel.GetCurrentPhase()<=PHASE_BATTLE)
end
function c34710660.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.SkipPhase(1-tp,PHASE_BATTLE,RESET_PHASE+PHASE_BATTLE_STEP,1)
end
