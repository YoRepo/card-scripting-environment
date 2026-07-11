--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:45
-- Source DB: cards.cdb
-- Card: Bujin Regalia - The Mirror  (ID: 35183853)
-- Type: Spell
-- Setcode: 0x88
-- Scope: OCG / TCG
--
-- Effect Text:
-- At the start of your Main Phase 1, if your opponent controls more monsters than you do and you
-- control a Beast-Warrior-Type "Bujin" monster: Until the end of your opponent's next turn, Spell/Trap
-- Cards, and their effects, cannot be activated.
--[[ __CARD_HEADER_END__ ]]

--鏡鳴する武神
function c35183853.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c35183853.condition)
	e1:SetOperation(c35183853.operation)
	c:RegisterEffect(e1)
end
function c35183853.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x88) and c:IsRace(RACE_BEASTWARRIOR)
end
function c35183853.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetCurrentPhase()==PHASE_MAIN1 and not Duel.CheckPhaseActivity()
		and Duel.GetFieldGroupCount(tp,LOCATION_MZONE,0)<Duel.GetFieldGroupCount(tp,0,LOCATION_MZONE)
		and Duel.IsExistingMatchingCard(c35183853.cfilter,tp,LOCATION_MZONE,0,1,nil)
end
function c35183853.operation(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EFFECT_CANNOT_ACTIVATE)
	e1:SetTargetRange(1,1)
	e1:SetValue(c35183853.aclimit)
	e1:SetReset(RESET_PHASE+PHASE_END,2)
	Duel.RegisterEffect(e1,tp)
end
function c35183853.aclimit(e,re,tp)
	return re:IsActiveType(TYPE_SPELL+TYPE_TRAP)
end
