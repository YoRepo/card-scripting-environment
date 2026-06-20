--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 黑暗中的陷阱  (ID: 79766336)
-- Type: Trap
-- ATK 0 | DEF 0
--
-- Effect Text:
-- ①：自己基本分是3000以下时，支付1000基本分，以「黑暗中的陷阱」以外的自己墓地1张通常陷阱卡为对象才能发动。这张卡的效果变成和那张墓地的通常陷阱卡发动时的效果相同。那之后，那张墓地的通常陷阱卡除
-- 外。
--[[ __CARD_HEADER_END__ ]]

--闇よりの罠
function c79766336.initial_effect(c)
	--copy trap
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0x1e1,0x1e1)
	e1:SetCondition(c79766336.condition)
	e1:SetCost(c79766336.cost)
	e1:SetTarget(c79766336.target)
	e1:SetOperation(c79766336.operation)
	c:RegisterEffect(e1)
end
function c79766336.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetLP(tp)<=3000
end
function c79766336.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(tp,1000) end
	Duel.PayLPCost(tp,1000)
end
function c79766336.filter(c)
	return c:GetType()==0x4 and not c:IsCode(79766336,22628574,6351147) and c:IsAbleToRemove() and c:CheckActivateEffect(false,true,false)~=nil
end
function c79766336.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then
		local te=e:GetLabelObject()
		local tg=te:GetTarget()
		return tg and tg(e,tp,eg,ep,ev,re,r,rp,0,chkc)
	end
	if chk==0 then return Duel.IsExistingTarget(c79766336.filter,tp,LOCATION_GRAVE,0,1,nil) end
	e:SetProperty(EFFECT_FLAG_CARD_TARGET)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	local g=Duel.SelectTarget(tp,c79766336.filter,tp,LOCATION_GRAVE,0,1,1,nil)
	local te,ceg,cep,cev,cre,cr,crp=g:GetFirst():CheckActivateEffect(false,true,true)
	Duel.ClearTargetCard()
	g:GetFirst():CreateEffectRelation(e)
	local tg=te:GetTarget()
	e:SetProperty(te:GetProperty())
	if tg then tg(e,tp,ceg,cep,cev,cre,cr,crp,1) end
	te:SetLabelObject(e:GetLabelObject())
	e:SetLabelObject(te)
	Duel.ClearOperationInfo(0)
end
function c79766336.operation(e,tp,eg,ep,ev,re,r,rp)
	local te=e:GetLabelObject()
	if not te then return end
	local tc=te:GetHandler()
	if not (tc:IsRelateToEffect(e) and tc:GetType()==TYPE_TRAP) then return end
	e:SetLabelObject(te:GetLabelObject())
	local op=te:GetOperation()
	if op then op(e,tp,eg,ep,ev,re,r,rp) end
	if tc:IsRelateToEffect(e) and tc:GetType()==TYPE_TRAP then
		Duel.BreakEffect()
		Duel.Remove(tc,POS_FACEUP,REASON_EFFECT)
	end
end
