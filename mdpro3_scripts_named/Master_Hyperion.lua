--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:30
-- Card: 主宰者·许珀里翁  (ID: 55794644)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Fairy
-- Level 8
-- ATK 2700 | DEF 2100
-- Setcode: 367
--
-- Effect Text:
-- ①：这张卡可以把自己的手卡·场上·墓地1只「代行者」怪兽除外，从手卡特殊召唤。
-- ②：1回合1次，从自己墓地把1只天使族·光属性怪兽除外，以场上1张卡为对象才能发动。那张卡破坏。场上有「天空的圣域」存在的场合，这个效果1回合可以使用最多2次。
--[[ __CARD_HEADER_END__ ]]

--マスター・ヒュペリオン
function c55794644.initial_effect(c)
	aux.AddCodeList(c,56433456)
	--spsummon proc
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c55794644.hspcon)
	e1:SetTarget(c55794644.hsptg)
	e1:SetOperation(c55794644.hspop)
	c:RegisterEffect(e1)
	--destroy
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(55794644,0))
	e2:SetCategory(CATEGORY_DESTROY)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCondition(c55794644.condition)
	e2:SetCost(c55794644.cost)
	e2:SetTarget(c55794644.target)
	e2:SetOperation(c55794644.operation)
	c:RegisterEffect(e2)
end
function c55794644.spfilter(c,tp)
	return c:IsSetCard(0x44) and c:IsAbleToRemoveAsCost() and (not c:IsLocation(LOCATION_MZONE) or c:IsFaceup())
		and Duel.GetMZoneCount(tp,c)>0
end
function c55794644.hspcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.IsExistingMatchingCard(c55794644.spfilter,tp,0x16,0,1,nil,tp)
end
function c55794644.hsptg(e,tp,eg,ep,ev,re,r,rp,chk,c)
	local g=Duel.GetMatchingGroup(c55794644.spfilter,tp,0x16,0,nil,tp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local tc=g:SelectUnselect(nil,tp,false,true,1,1)
	if tc then
		e:SetLabelObject(tc)
		return true
	else return false end
end
function c55794644.hspop(e,tp,eg,ep,ev,re,r,rp,c)
	local g=e:GetLabelObject()
	Duel.Remove(g,POS_FACEUP,REASON_SPSUMMON)
end
function c55794644.condition(e,tp,eg,ep,ev,re,r,rp)
	if Duel.IsEnvironment(56433456) then return e:GetHandler():GetFlagEffect(55794644)<2
	else return e:GetHandler():GetFlagEffect(55794644)<1 end
end
function c55794644.costfilter(c)
	return c:IsAttribute(ATTRIBUTE_LIGHT) and c:IsRace(RACE_FAIRY) and c:IsAbleToRemoveAsCost()
end
function c55794644.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c55794644.costfilter,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,c55794644.costfilter,tp,LOCATION_GRAVE,0,1,1,nil)
	Duel.Remove(g,POS_FACEUP,REASON_COST)
end
function c55794644.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() end
	if chk==0 then return Duel.IsExistingTarget(aux.TRUE,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,aux.TRUE,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
	e:GetHandler():RegisterFlagEffect(55794644,RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END,0,1)
end
function c55794644.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end
