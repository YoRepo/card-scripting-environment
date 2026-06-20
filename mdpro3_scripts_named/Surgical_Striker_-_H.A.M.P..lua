--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:26
-- Card: 闪术兵器-汉普  (ID: 33331231)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Machine
-- Level 8
-- ATK 2500 | DEF 2500
-- Setcode: 277
--
-- Effect Text:
-- 这个卡名在规则上也当作「闪刀」卡使用。这个卡名的①的方法的特殊召唤1回合只能有1次。
-- ①：自己场上有「闪刀姬」怪兽存在的场合，这张卡可以把自己或者对方场上1只怪兽解放，从手卡往那个控制者场上特殊召唤。
-- ②：这张卡被战斗破坏时，以对方场上1张卡为对象才能发动。那张卡破坏。
--[[ __CARD_HEADER_END__ ]]

--閃術兵器－H.A.M.P.
function c33331231.initial_effect(c)
	--special summon rule(on self field)
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(33331231,0))
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetRange(LOCATION_HAND)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetCountLimit(1,33331231+EFFECT_COUNT_CODE_OATH)
	e1:SetCondition(c33331231.spcon)
	e1:SetTarget(c33331231.sptg)
	e1:SetOperation(c33331231.spop)
	c:RegisterEffect(e1)
	--special summon rule(on oppent field)
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(33331231,1))
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_SPSUMMON_PROC)
	e2:SetRange(LOCATION_HAND)
	e2:SetProperty(EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_SPSUM_PARAM)
	e2:SetTargetRange(POS_FACEUP,1)
	e2:SetCountLimit(1,33331231+EFFECT_COUNT_CODE_OATH)
	e2:SetCondition(c33331231.spcon2)
	e2:SetTarget(c33331231.sptg2)
	e2:SetOperation(c33331231.spop)
	c:RegisterEffect(e2)
	--destroy
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(33331231,2))
	e3:SetCategory(CATEGORY_DESTROY)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetCode(EVENT_BATTLE_DESTROYED)
	e3:SetTarget(c33331231.dstg)
	e3:SetOperation(c33331231.dsop)
	c:RegisterEffect(e3)
end
function c33331231.checkfilter(c)
	return c:IsSetCard(0x1115) and c:IsFaceup()
end
function c33331231.sprfilter(c,tp,sp)
	return c:IsReleasable(REASON_SPSUMMON) and Duel.GetMZoneCount(tp,c,sp)>0
end
function c33331231.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.IsExistingMatchingCard(c33331231.checkfilter,tp,LOCATION_MZONE,0,1,nil)
		and Duel.IsExistingMatchingCard(c33331231.sprfilter,tp,LOCATION_MZONE,0,1,nil,tp,tp)
end
function c33331231.sptg(e,tp,eg,ep,ev,re,r,rp,chk,c)
	local g=Duel.GetMatchingGroup(c33331231.sprfilter,tp,LOCATION_MZONE,0,nil,tp,tp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RELEASE)
	local tc=g:SelectUnselect(nil,tp,false,true,1,1)
	if tc then
		e:SetLabelObject(tc)
		return true
	else return false end
end
function c33331231.spop(e,tp,eg,ep,ev,re,r,rp,c)
	local g=e:GetLabelObject()
	Duel.Release(g,REASON_SPSUMMON)
end
function c33331231.spcon2(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.IsExistingMatchingCard(c33331231.checkfilter,tp,LOCATION_MZONE,0,1,nil)
		and Duel.IsExistingMatchingCard(c33331231.sprfilter,tp,0,LOCATION_MZONE,1,nil,1-tp,tp)
end
function c33331231.sptg2(e,tp,eg,ep,ev,re,r,rp,chk,c)
	local g=Duel.GetMatchingGroup(c33331231.sprfilter,tp,0,LOCATION_MZONE,nil,1-tp,tp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RELEASE)
	local tc=g:SelectUnselect(nil,tp,false,true,1,1)
	if tc then
		e:SetLabelObject(tc)
		return true
	else return false end
end
function c33331231.dstg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(1-tp) and chkc:IsOnField() end
	if chk==0 then return Duel.IsExistingTarget(nil,tp,0,LOCATION_ONFIELD,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,nil,tp,0,LOCATION_ONFIELD,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c33331231.dsop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end
