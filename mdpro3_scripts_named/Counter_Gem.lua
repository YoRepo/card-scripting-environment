--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 反击宝石  (ID: 11136371)
-- Type: Trap
-- ATK 0 | DEF 0
-- Setcode: 71
--
-- Effect Text:
-- ①：把这张卡以外的自己的魔法与陷阱区域的卡全部送去墓地才能发动。从自己墓地把「宝玉兽」怪兽尽可能当作永续魔法卡使用在自己的魔法与陷阱区域表侧表示放置。这个回合的结束阶段让自己场上的「宝玉兽」卡全部破坏
-- 。
--[[ __CARD_HEADER_END__ ]]

--カウンター・ジェム
function c11136371.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c11136371.plcost)
	e1:SetTarget(c11136371.pltg)
	e1:SetOperation(c11136371.plop)
	c:RegisterEffect(e1)
end
function c11136371.cfilter(c)
	return c:GetSequence()<5 and c:IsAbleToGraveAsCost()
end
function c11136371.plcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c11136371.cfilter,tp,LOCATION_SZONE,0,1,e:GetHandler()) end
	local g=Duel.GetMatchingGroup(c11136371.cfilter,tp,LOCATION_SZONE,0,e:GetHandler())
	Duel.SendtoGrave(g,REASON_COST)
end
function c11136371.plfilter(c)
	return c:IsSetCard(0x1034) and c:IsType(TYPE_MONSTER) and not c:IsForbidden()
end
function c11136371.pltg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c11136371.plfilter,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_LEAVE_GRAVE,nil,1,tp,LOCATION_GRAVE)
end
function c11136371.plop(e,tp,eg,ep,ev,re,r,rp)
	local ft=Duel.GetLocationCount(tp,LOCATION_SZONE)
	if ft<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOFIELD)
	local g=Duel.SelectMatchingCard(tp,c11136371.plfilter,tp,LOCATION_GRAVE,0,ft,ft,nil)
	if g:GetCount()>0 then
		local tc=g:GetFirst()
		while tc do
			Duel.MoveToField(tc,tp,tp,LOCATION_SZONE,POS_FACEUP,true)
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetCode(EFFECT_CHANGE_TYPE)
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
			e1:SetReset(RESET_EVENT+RESETS_STANDARD-RESET_TURN_SET)
			e1:SetValue(TYPE_SPELL+TYPE_CONTINUOUS)
			tc:RegisterEffect(e1)
			tc=g:GetNext()
		end
	end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_PHASE+PHASE_END)
	e1:SetCountLimit(1)
	e1:SetReset(RESET_PHASE+PHASE_END)
	e1:SetCondition(c11136371.descon)
	e1:SetOperation(c11136371.desop)
	Duel.RegisterEffect(e1,tp)
end
function c11136371.desfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x1034)
end
function c11136371.descon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c11136371.desfilter,tp,LOCATION_ONFIELD,0,1,nil)
end
function c11136371.desop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c11136371.desfilter,tp,LOCATION_ONFIELD,0,nil)
	Duel.Destroy(g,REASON_EFFECT)
end
