--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 超级量子机兽 大气衔尾蛇  (ID: 11646785)
-- Type: Monster / Effect / Xyz
-- Attribute: WIND
-- Race: Machine
-- Rank 4
-- ATK 2200 | DEF 2400
-- Setcode: 8412
--
-- Effect Text:
-- 4星怪兽×2
-- ①：没有超量素材的这张卡不能攻击。
-- ②：1回合1次，把这张卡1个超量素材取除，以这张卡以外的场上1只表侧表示怪兽为对象才能发动。那只怪兽变成里侧守备表示。这张卡有「超级量子战士 绿光层」在作为超量素材的场合，这个效果在对方回合也能发动。
-- ③：1回合1次，自己主要阶段才能发动。选自己的手卡·场上1只「超级量子战士」怪兽在这张卡下面重叠作为超量素材。
--[[ __CARD_HEADER_END__ ]]

--超量機獣エアロボロス
function c11646785.initial_effect(c)
	aux.AddCodeList(c,85374678)
	--xyz summon
	aux.AddXyzProcedure(c,nil,4,2)
	c:EnableReviveLimit()
	--cannot attack
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_CANNOT_ATTACK)
	e1:SetCondition(c11646785.atcon)
	c:RegisterEffect(e1)
	--pos
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(11646785,0))
	e2:SetCategory(CATEGORY_POSITION+CATEGORY_MSET)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1,EFFECT_COUNT_CODE_SINGLE)
	e2:SetCondition(c11646785.setcon1)
	e2:SetCost(c11646785.setcost)
	e2:SetTarget(c11646785.settg)
	e2:SetOperation(c11646785.setop)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetType(EFFECT_TYPE_QUICK_O)
	e3:SetCode(EVENT_FREE_CHAIN)
	e3:SetHintTiming(0,TIMINGS_CHECK_MONSTER+TIMING_END_PHASE)
	e3:SetCondition(c11646785.setcon2)
	c:RegisterEffect(e3)
	--material
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(11646785,1))
	e4:SetType(EFFECT_TYPE_IGNITION)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCountLimit(1)
	e4:SetTarget(c11646785.mttg)
	e4:SetOperation(c11646785.mtop)
	c:RegisterEffect(e4)
end
function c11646785.atcon(e)
	return e:GetHandler():GetOverlayCount()==0
end
function c11646785.setcon1(e,tp,eg,ep,ev,re,r,rp)
	return not e:GetHandler():GetOverlayGroup():IsExists(Card.IsCode,1,nil,85374678)
end
function c11646785.setcon2(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetOverlayGroup():IsExists(Card.IsCode,1,nil,85374678)
end
function c11646785.setcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c11646785.setfilter(c)
	return c:IsFaceup() and c:IsCanTurnSet()
end
function c11646785.settg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c11646785.setfilter(chkc) and chkc~=e:GetHandler() end
	if chk==0 then return Duel.IsExistingTarget(c11646785.setfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,e:GetHandler()) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_POSCHANGE)
	local g=Duel.SelectTarget(tp,c11646785.setfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,e:GetHandler())
	Duel.SetOperationInfo(0,CATEGORY_POSITION,g,1,0,0)
end
function c11646785.setop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsFaceup() and tc:IsRelateToEffect(e) then
		Duel.ChangePosition(tc,POS_FACEDOWN_DEFENSE)
	end
end
function c11646785.mtfilter(c,e)
	return c:IsFaceupEx() and c:IsType(TYPE_MONSTER) and c:IsSetCard(0x10dc) and c:IsCanOverlay() and not (e and c:IsImmuneToEffect(e))
end
function c11646785.mttg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsType(TYPE_XYZ)
		and Duel.IsExistingMatchingCard(c11646785.mtfilter,tp,LOCATION_HAND+LOCATION_MZONE,0,1,nil) end
end
function c11646785.mtop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_XMATERIAL)
	local g=Duel.SelectMatchingCard(tp,c11646785.mtfilter,tp,LOCATION_HAND+LOCATION_MZONE,0,1,1,nil,e)
	if g:GetCount()>0 then
		local mg=g:GetFirst():GetOverlayGroup()
		if mg:GetCount()>0 then
			Duel.SendtoGrave(mg,REASON_RULE)
		end
		Duel.Overlay(c,g)
	end
end
