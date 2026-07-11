--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:50
-- Source DB: cards.cdb
-- Card: Enlightenment  (ID: 57274196)
-- Type: Trap
-- Scope: OCG / TCG
--
-- Effect Text:
-- You cannot Summon the turn you activate this card.
-- Activate at the end of the Damage Step, if a Spellcaster-Type monster you control attacked and
-- destroyed an opponent's monster by battle.
-- That monster can attack again (immediately).
--[[ __CARD_HEADER_END__ ]]

--未来王の予言
function c57274196.initial_effect(c)
	--chain attack
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_BATTLE_DESTROYING)
	e1:SetCondition(c57274196.condition)
	e1:SetCost(c57274196.cost)
	e1:SetOperation(c57274196.operation)
	c:RegisterEffect(e1)
end
function c57274196.condition(e,tp,eg,ep,ev,re,r,rp)
	local tc=eg:GetFirst()
	return tc:IsControler(tp) and tc:IsRace(RACE_SPELLCASTER) and tc:IsChainAttackable() and tc:IsStatus(STATUS_OPPO_BATTLE)
end
function c57274196.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetActivityCount(tp,ACTIVITY_SUMMON)==0
		and Duel.GetActivityCount(tp,ACTIVITY_FLIPSUMMON)==0 and Duel.GetActivityCount(tp,ACTIVITY_SPSUMMON)==0 end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_OATH)
	e1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e1:SetReset(RESET_PHASE+PHASE_END)
	e1:SetTargetRange(1,0)
	e1:SetLabelObject(e)
	Duel.RegisterEffect(e1,tp)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_CANNOT_SUMMON)
	Duel.RegisterEffect(e2,tp)
	local e3=e1:Clone()
	e3:SetCode(EFFECT_CANNOT_FLIP_SUMMON)
	Duel.RegisterEffect(e3,tp)
end
function c57274196.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.ChainAttack()
end
