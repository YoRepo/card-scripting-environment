--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:37
-- Card: 灭绝的定数  (ID: 95676943)
-- Type: Trap
-- ATK 0 | DEF 0
--
-- Effect Text:
-- ①：自己·对方的主要阶段支付2000基本分才能发动。这张卡的发动后第3次的战斗阶段结束时，双方玩家必须把各自场上的卡全部送去墓地。
--[[ __CARD_HEADER_END__ ]]

--絶滅の定め
function c95676943.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMING_MAIN_END)
	e1:SetCondition(c95676943.condition)
	e1:SetCost(c95676943.cost)
	e1:SetTarget(c95676943.target)
	e1:SetOperation(c95676943.activate)
	c:RegisterEffect(e1)
end
function c95676943.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetCurrentPhase()==PHASE_MAIN1 or Duel.GetCurrentPhase()==PHASE_MAIN2
end
function c95676943.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(tp,2000) end
	Duel.PayLPCost(tp,2000)
end
function c95676943.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:IsHasType(EFFECT_TYPE_ACTIVATE) end
end
function c95676943.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	c:SetTurnCounter(0)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_PHASE+PHASE_BATTLE)
	e1:SetCountLimit(1)
	e1:SetOperation(c95676943.tgop)
	e1:SetReset(RESET_PHASE+PHASE_BATTLE,3)
	Duel.RegisterEffect(e1,tp)
end
function c95676943.tgop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local ct=c:GetTurnCounter()
	ct=ct+1
	c:SetTurnCounter(ct)
	if ct==3 then
		local g=Duel.GetFieldGroup(tp,LOCATION_ONFIELD,LOCATION_ONFIELD)
		Duel.SendtoGrave(g,REASON_RULE)
	end
end
