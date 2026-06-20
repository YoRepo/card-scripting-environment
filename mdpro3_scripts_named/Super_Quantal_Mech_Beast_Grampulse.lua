--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: 超级量子机兽 脉冲虎鲸  (ID: 85252081)
-- Type: Monster / Effect / Xyz
-- Attribute: WATER
-- Race: Machine
-- Rank 3
-- ATK 1800 | DEF 2800
-- Setcode: 8412
--
-- Effect Text:
-- 3星怪兽×2
-- ①：没有超量素材的这张卡不能攻击。
-- ②：1回合1次，把这张卡1个超量素材取除，以场上1张魔法·陷阱卡为对象才能发动。那张卡破坏。这张卡有「超级量子战士 蓝光层」在作为超量素材的场合，这个效果在对方回合也能发动。
-- ③：1回合1次，自己主要阶段才能发动。选自己的手卡·场上1只「超级量子战士」怪兽在这张卡下面重叠作为超量素材。
--[[ __CARD_HEADER_END__ ]]

--超量機獣グランパルス
function c85252081.initial_effect(c)
	aux.AddCodeList(c,12369277)
	--xyz summon
	aux.AddXyzProcedure(c,nil,3,2)
	c:EnableReviveLimit()
	--cannot attack
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_CANNOT_ATTACK)
	e1:SetCondition(c85252081.atcon)
	c:RegisterEffect(e1)
	--destroy
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_DESTROY)
	e2:SetDescription(aux.Stringid(85252081,0))
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1,EFFECT_COUNT_CODE_SINGLE)
	e2:SetCondition(c85252081.descon1)
	e2:SetCost(c85252081.descost)
	e2:SetTarget(c85252081.destg)
	e2:SetOperation(c85252081.desop)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetType(EFFECT_TYPE_QUICK_O)
	e3:SetCode(EVENT_FREE_CHAIN)
	e3:SetHintTiming(0,TIMING_END_PHASE+TIMING_EQUIP)
	e3:SetCondition(c85252081.descon2)
	c:RegisterEffect(e3)
	--material
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(85252081,1))
	e4:SetType(EFFECT_TYPE_IGNITION)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCountLimit(1)
	e4:SetTarget(c85252081.mttg)
	e4:SetOperation(c85252081.mtop)
	c:RegisterEffect(e4)
end
function c85252081.atcon(e)
	return e:GetHandler():GetOverlayCount()==0
end
function c85252081.descon1(e,tp,eg,ep,ev,re,r,rp)
	return not e:GetHandler():GetOverlayGroup():IsExists(Card.IsCode,1,nil,12369277)
end
function c85252081.descon2(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetOverlayGroup():IsExists(Card.IsCode,1,nil,12369277)
end
function c85252081.descost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c85252081.desfilter(c)
	return c:IsType(TYPE_SPELL+TYPE_TRAP)
end
function c85252081.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c85252081.desfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c85252081.desfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,c85252081.desfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c85252081.desop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end
function c85252081.mtfilter(c,e)
	return c:IsFaceupEx() and c:IsType(TYPE_MONSTER) and c:IsSetCard(0x10dc) and c:IsCanOverlay() and not (e and c:IsImmuneToEffect(e))
end
function c85252081.mttg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsType(TYPE_XYZ)
		and Duel.IsExistingMatchingCard(c85252081.mtfilter,tp,LOCATION_HAND+LOCATION_MZONE,0,1,nil) end
end
function c85252081.mtop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_XMATERIAL)
	local g=Duel.SelectMatchingCard(tp,c85252081.mtfilter,tp,LOCATION_HAND+LOCATION_MZONE,0,1,1,nil,e)
	if g:GetCount()>0 then
		local mg=g:GetFirst():GetOverlayGroup()
		if mg:GetCount()>0 then
			Duel.SendtoGrave(mg,REASON_RULE)
		end
		Duel.Overlay(c,g)
	end
end
