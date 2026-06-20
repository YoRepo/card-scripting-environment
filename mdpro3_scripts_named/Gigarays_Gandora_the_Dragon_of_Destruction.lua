--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:31
-- Card: 破坏龙 甘多拉-烈光闪  (ID: 58330108)
-- Type: Monster / Effect / SpecialSummon
-- Attribute: DARK
-- Race: Dragon
-- Level 8
-- ATK 0 | DEF 0
-- Setcode: 245
--
-- Effect Text:
-- 这张卡不能通常召唤。把这张卡以外的自己的手卡·场上2只怪兽送去墓地的场合可以特殊召唤。
-- ①：这张卡的攻击力上升除外中的卡数量×300。
-- ②：1回合1次，把基本分支付一半才能发动。自己墓地的「甘多拉」怪兽种类对应的以下适用。
-- ●1种类：这张卡以外的场上的卡全部破坏。
-- ●2种类：这张卡以外的场上的卡全部除外。
-- ●3种类以上：这张卡以外的双方的场上·墓地的卡全部除外。
--[[ __CARD_HEADER_END__ ]]

--破壊竜ガンドラ－ギガ・レイズ
function c58330108.initial_effect(c)
	c:EnableReviveLimit()
	--special summon rule
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c58330108.spcon)
	e1:SetTarget(c58330108.sptg)
	e1:SetOperation(c58330108.spop)
	c:RegisterEffect(e1)
	--atk gain
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetRange(LOCATION_MZONE)
	e2:SetValue(c58330108.value)
	c:RegisterEffect(e2)
	--variable effect
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(58330108,0))
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1)
	e3:SetCost(c58330108.cost)
	e3:SetTarget(c58330108.target)
	e3:SetOperation(c58330108.operation)
	c:RegisterEffect(e3)
end
function c58330108.cfilter(c)
	return c:IsType(TYPE_MONSTER) and c:IsAbleToGraveAsCost()
end
function c58330108.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	local g=Duel.GetMatchingGroup(c58330108.cfilter,tp,LOCATION_MZONE+LOCATION_HAND,0,c)
	return g:CheckSubGroup(aux.mzctcheck,2,2,tp)
end
function c58330108.sptg(e,tp,eg,ep,ev,re,r,rp,chk,c)
	local g=Duel.GetMatchingGroup(c58330108.cfilter,tp,LOCATION_MZONE+LOCATION_HAND,0,c)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local sg=g:SelectSubGroup(tp,aux.mzctcheck,true,2,2,tp)
	if sg then
		sg:KeepAlive()
		e:SetLabelObject(sg)
		return true
	else return false end
end
function c58330108.spop(e,tp,eg,ep,ev,re,r,rp,c)
	local g=e:GetLabelObject()
	Duel.SendtoGrave(g,REASON_SPSUMMON)
	g:DeleteGroup()
end
function c58330108.value(e,c)
	return Duel.GetFieldGroupCount(c:GetControler(),LOCATION_REMOVED,LOCATION_REMOVED)*300
end
function c58330108.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.PayLPCost(tp,math.floor(Duel.GetLP(tp)/2))
end
function c58330108.filter(c)
	return c:IsType(TYPE_MONSTER) and c:IsSetCard(0xf5)
end
function c58330108.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	local gc=Duel.GetMatchingGroup(c58330108.filter,tp,LOCATION_GRAVE,0,nil):GetClassCount(Card.GetCode)
	if chk==0 then
		local b1=Duel.IsExistingMatchingCard(nil,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,c)
		local b2=Duel.IsExistingMatchingCard(Card.IsAbleToRemove,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,c)
		local b3=Duel.IsExistingMatchingCard(Card.IsAbleToRemove,tp,LOCATION_ONFIELD+LOCATION_GRAVE,LOCATION_ONFIELD+LOCATION_GRAVE,1,c)
		return (gc==1 and b1) or (gc==2 and b2) or (gc>2 and b3)
	end
	if gc==1 then
		e:SetCategory(CATEGORY_DESTROY)
		local g=Duel.GetMatchingGroup(nil,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,c)
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
	else
		e:SetCategory(CATEGORY_REMOVE)
		local loc=LOCATION_ONFIELD
		if gc>2 then loc=LOCATION_ONFIELD+LOCATION_GRAVE end
		local g=Duel.GetMatchingGroup(Card.IsAbleToRemove,tp,loc,loc,c)
		Duel.SetOperationInfo(0,CATEGORY_REMOVE,g,g:GetCount(),0,0)
	end
end
function c58330108.operation(e,tp,eg,ep,ev,re,r,rp)
	local gc=Duel.GetMatchingGroup(c58330108.filter,tp,LOCATION_GRAVE,0,nil):GetClassCount(Card.GetCode)
	if gc==1 then
		local g=Duel.GetMatchingGroup(nil,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,aux.ExceptThisCard(e))
		Duel.Destroy(g,REASON_EFFECT)
	elseif gc>=2 then
		local loc=LOCATION_ONFIELD
		if gc>2 then loc=LOCATION_ONFIELD+LOCATION_GRAVE end
		local g=Duel.GetMatchingGroup(Card.IsAbleToRemove,tp,loc,loc,aux.ExceptThisCard(e))
		Duel.Remove(g,POS_FACEUP,REASON_EFFECT)
	end
end
