--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:30
-- Card: 仪式破势  (ID: 54094821)
-- Type: Trap
-- ATK 0 | DEF 0
-- Setcode: 58
--
-- Effect Text:
-- ①：自己或者对方仪式召唤成功时才能发动。直到下次的自己回合的准备阶段，对方不能作魔法·陷阱卡的发动以及那个效果的发动。
--[[ __CARD_HEADER_END__ ]]

--リチュアルバスター
function c54094821.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCondition(c54094821.condition)
	e1:SetOperation(c54094821.activate)
	c:RegisterEffect(e1)
end
function c54094821.cfilter(c)
	return c:IsSummonType(SUMMON_TYPE_RITUAL)
end
function c54094821.condition(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c54094821.cfilter,1,nil)
end
function c54094821.activate(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EFFECT_CANNOT_ACTIVATE)
	e1:SetTargetRange(0,1)
	e1:SetValue(c54094821.aclimit)
	if Duel.GetTurnPlayer()==tp and Duel.GetCurrentPhase()<=PHASE_STANDBY then
		e1:SetReset(RESET_PHASE+PHASE_STANDBY+RESET_SELF_TURN,2)
	else
		e1:SetReset(RESET_PHASE+PHASE_STANDBY+RESET_SELF_TURN)
	end
	Duel.RegisterEffect(e1,tp)
end
function c54094821.aclimit(e,re,tp)
	return re:GetHandler():IsType(TYPE_SPELL+TYPE_TRAP)
end
