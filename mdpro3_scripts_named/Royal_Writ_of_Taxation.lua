--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: 王宫的重税  (ID: 86742443)
-- Type: Trap
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 对方回合的准备阶段时才能发动。随机选择对方的1张手卡并确认。选择的卡或者同名卡直到下次自己的结束阶段结束时没有召唤或者发动的场合，给与对方基本分1000分伤害。有召唤或者发动的场合，自己受到1000分
-- 伤害。
--[[ __CARD_HEADER_END__ ]]

--王宮の重税
function c86742443.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(TIMING_STANDBY_PHASE)
	e1:SetCondition(c86742443.condition)
	e1:SetTarget(c86742443.target)
	e1:SetOperation(c86742443.operation)
	c:RegisterEffect(e1)
end
function c86742443.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetCurrentPhase()==PHASE_STANDBY and Duel.GetTurnPlayer()~=tp
end
function c86742443.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFieldGroupCount(1-tp,LOCATION_HAND,0)>0 end
end
function c86742443.operation(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetFieldGroupCount(1-tp,LOCATION_HAND,0)==0 then return end
	local g=Duel.GetFieldGroup(1-tp,LOCATION_HAND,0):RandomSelect(tp,1)
	local tc=g:GetFirst()
	Duel.ConfirmCards(tp,tc)
	Duel.ShuffleHand(1-tp)
	local code=tc:GetCode()
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_PHASE+PHASE_END)
	e1:SetCountLimit(1)
	e1:SetCondition(c86742443.damcon)
	e1:SetOperation(c86742443.damop)
	e1:SetLabel(0)
	e1:SetReset(RESET_PHASE+PHASE_END,2)
	Duel.RegisterEffect(e1,tp)
	local e2=Effect.CreateEffect(e:GetHandler())
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_SUMMON_SUCCESS)
	e2:SetOperation(c86742443.damop2)
	e2:SetCountLimit(1)
	e2:SetLabelObject(e1)
	e2:SetLabel(code)
	e2:SetReset(RESET_PHASE+PHASE_END,2)
	Duel.RegisterEffect(e2,tp)
	local e3=Effect.CreateEffect(e:GetHandler())
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e3:SetProperty(EFFECT_FLAG_DELAY)
	e3:SetCode(EVENT_CHAIN_SOLVING)
	e3:SetOperation(c86742443.damop3)
	e3:SetCountLimit(1)
	e3:SetLabelObject(e1)
	e3:SetLabel(code)
	e3:SetReset(RESET_PHASE+PHASE_END,2)
	Duel.RegisterEffect(e3,tp)
end
function c86742443.damcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp and e:GetLabel()==0
end
function c86742443.damop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Damage(1-tp,1000,REASON_EFFECT)
end
function c86742443.damop2(e,tp,eg,ep,ev,re,r,rp)
	if eg:GetFirst():IsCode(e:GetLabel()) then
		Duel.Damage(tp,1000,REASON_EFFECT)
		e:GetLabelObject():SetLabel(1)
	end
end
function c86742443.damop3(e,tp,eg,ep,ev,re,r,rp)
	if re:GetHandler():IsCode(e:GetLabel()) then
		Duel.Damage(tp,1000,REASON_EFFECT)
		e:GetLabelObject():SetLabel(1)
	end
end
