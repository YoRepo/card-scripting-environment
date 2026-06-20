--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 地磅计量  (ID: 39103226)
-- Type: Trap
-- ATK 0 | DEF 0
--
-- Effect Text:
-- ①：对方场上的怪兽数量比自己场上的怪兽多2只以上的场合才能发动。对方直到自身场上的怪兽变成1只为止必须送去墓地。
--[[ __CARD_HEADER_END__ ]]

--台貫計量
function c39103226.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOGRAVE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMINGS_CHECK_MONSTER+TIMING_END_PHASE)
	e1:SetCondition(c39103226.condition)
	e1:SetTarget(c39103226.target)
	e1:SetOperation(c39103226.operation)
	c:RegisterEffect(e1)
end
function c39103226.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetFieldGroupCount(tp,0,LOCATION_MZONE)-Duel.GetFieldGroupCount(tp,LOCATION_MZONE,0)>=2
end
function c39103226.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local mc=Duel.GetFieldGroupCount(tp,0,LOCATION_MZONE)
	local count=mc-1
	if chk==0 then return count>0 end
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,count,1-tp,LOCATION_MZONE)
end
function c39103226.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetFieldGroup(1-tp,LOCATION_MZONE,0)
	local count=g:GetCount()-1
	if count>0 then
		Duel.Hint(HINT_SELECTMSG,1-tp,HINTMSG_TOGRAVE)
		local sg=g:Select(1-tp,count,count,nil)
		Duel.HintSelection(sg)
		Duel.SendtoGrave(sg,REASON_RULE)
	end
end
