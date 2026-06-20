--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:36
-- Card: 血之刻印  (ID: 94463200)
-- Type: Trap / Equip
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 选择自己场上1只名称中含有「恶魔」字样的怪兽发动。所选择的怪兽在准备阶段支付基本分时，对方也要支付相同的基本分。当这张卡离场时，所选择的怪兽被破坏；当所选择的怪兽离场时，这张卡被破坏。
--[[ __CARD_HEADER_END__ ]]

--血の刻印
function c94463200.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(TIMING_STANDBY_PHASE,0)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetTarget(c94463200.target)
	e1:SetOperation(c94463200.operation)
	c:RegisterEffect(e1)
	--lpcost
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCode(EVENT_PAY_LPCOST)
	e2:SetCondition(c94463200.lpcon)
	e2:SetOperation(c94463200.lpop)
	c:RegisterEffect(e2)
	--Destroy
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCode(EVENT_LEAVE_FIELD)
	e3:SetCondition(c94463200.descon)
	e3:SetOperation(c94463200.desop)
	c:RegisterEffect(e3)
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e4:SetCode(EVENT_LEAVE_FIELD)
	e4:SetOperation(c94463200.desop2)
	c:RegisterEffect(e4)
end
function c94463200.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x45)
end
function c94463200.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c94463200.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c94463200.filter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c94463200.filter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c94463200.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if c:IsRelateToEffect(e) and tc:IsFaceup() and tc:IsRelateToEffect(e) then
		c:SetCardTarget(tc)
	end
end
function c94463200.lpcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetCurrentPhase()==PHASE_STANDBY and ep==tp
		and re:GetHandler()==e:GetHandler():GetFirstCardTarget()
end
function c94463200.lpop(e,tp,eg,ep,ev,re,r,rp)
	Duel.PayLPCost(1-ep,ev)
end
function c94463200.descon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsStatus(STATUS_DESTROY_CONFIRMED) then return false end
	local tc=c:GetFirstCardTarget()
	return tc and eg:IsContains(tc) and tc:IsReason(REASON_DESTROY)
end
function c94463200.desop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Destroy(e:GetHandler(),REASON_EFFECT)
end
function c94463200.desop2(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetHandler():GetFirstCardTarget()
	if tc and tc:IsLocation(LOCATION_MZONE) then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end
