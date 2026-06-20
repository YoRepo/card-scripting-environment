--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 扫除机块 真空吸尘象  (ID: 30118200)
-- Type: Monster / Effect / Link
-- Attribute: DARK
-- Race: Machine
-- ATK 1000 | LINK
-- Setcode: 331
--
-- Effect Text:
-- 「机块」怪兽1只
-- 这个卡名的①②的效果1回合只能有1次使用其中任意1个。这张卡在连接召唤的回合不能作为连接素材。
-- ①：把1张手卡送去墓地，以对方场上1张卡为对象才能发动。那张卡破坏。
-- ②：这张卡是互相连接状态的场合，以对方的主要怪兽区域1只怪兽为对象才能发动。那只怪兽破坏。
-- ③：这张卡不是互相连接状态的场合，这张卡可以直接攻击。
--[[ __CARD_HEADER_END__ ]]

--掃除機塊バキューネシア
function c30118200.initial_effect(c)
	--link summon
	c:EnableReviveLimit()
	aux.AddLinkProcedure(c,aux.FilterBoolFunction(Card.IsLinkSetCard,0x14b),1,1)
	--cannot link material
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_CANNOT_BE_LINK_MATERIAL)
	e1:SetValue(c30118200.lmlimit)
	c:RegisterEffect(e1)
	--destroy1
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(30118200,0))
	e2:SetCategory(CATEGORY_DESTROY)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1,30118200)
	e2:SetCost(c30118200.descost)
	e2:SetTarget(c30118200.destg1)
	e2:SetOperation(c30118200.desop)
	c:RegisterEffect(e2)
	--destroy2
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(30118200,1))
	e3:SetCategory(CATEGORY_DESTROY)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1,30118200)
	e3:SetCondition(c30118200.descon)
	e3:SetTarget(c30118200.destg2)
	e3:SetOperation(c30118200.desop)
	c:RegisterEffect(e3)
	--direct attack
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetCode(EFFECT_DIRECT_ATTACK)
	e4:SetCondition(c30118200.dircon)
	c:RegisterEffect(e4)
end
function c30118200.lmlimit(e)
	local c=e:GetHandler()
	return c:IsStatus(STATUS_SPSUMMON_TURN) and c:IsSummonType(SUMMON_TYPE_LINK)
end
function c30118200.dircon(e)
	return e:GetHandler():GetMutualLinkedGroupCount()==0
end
function c30118200.descost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsAbleToGraveAsCost,tp,LOCATION_HAND,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,Card.IsAbleToGraveAsCost,tp,LOCATION_HAND,0,1,1,nil)
	Duel.SendtoGrave(g,REASON_COST)
end
function c30118200.destg1(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and chkc:IsControler(1-tp) end
	if chk==0 then return Duel.IsExistingTarget(aux.TRUE,tp,0,LOCATION_ONFIELD,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,aux.TRUE,tp,0,LOCATION_ONFIELD,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c30118200.desop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end
function c30118200.descon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetMutualLinkedGroupCount()>0
end
function c30118200.desfilter(c)
	return c:GetSequence()<5
end
function c30118200.destg2(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) and c30118200.desfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c30118200.desfilter,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,c30118200.desfilter,tp,0,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
