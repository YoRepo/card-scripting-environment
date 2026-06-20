--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 阿吉罗斯的落胤  (ID: 82090807)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Thunder
-- Level 2
-- ATK 700 | DEF 700
--
-- Effect Text:
-- 这个卡名的①的方法的特殊召唤1回合只能有1次，③的效果1回合只能使用1次。
-- ①：场上有2星·2阶·连接2的怪兽的其中任意种存在的场合，这张卡可以从手卡往自己或者对方场上特殊召唤。
-- ②：双方不能把有这张卡位于所连接区的连接怪兽的效果发动。
-- ③：对方回合，以场上1只超量怪兽为对象才能发动。那只怪兽最多2个超量素材取除。
--[[ __CARD_HEADER_END__ ]]

--アルギロスの落胤
function c82090807.initial_effect(c)
	--spsummon rule or self
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(82090807,0))
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,82090807+EFFECT_COUNT_CODE_OATH)
	e1:SetCondition(c82090807.sprcon1)
	c:RegisterEffect(e1)
	--spsummon rule or your opponent
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(82090807,1))
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_SPSUMMON_PROC)
	e2:SetRange(LOCATION_HAND)
	e2:SetProperty(EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_SPSUM_PARAM)
	e2:SetTargetRange(POS_FACEUP,1)
	e2:SetCountLimit(1,82090807+EFFECT_COUNT_CODE_OATH)
	e2:SetCondition(c82090807.sprcon2)
	c:RegisterEffect(e2)
	--act limit
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCode(EFFECT_CANNOT_TRIGGER)
	e3:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
	e3:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e3:SetTarget(c82090807.actfilter)
	c:RegisterEffect(e3)
	--xyz material detach
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(82090807,2))
	e4:SetType(EFFECT_TYPE_QUICK_O)
	e4:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e4:SetCode(EVENT_FREE_CHAIN)
	e4:SetRange(LOCATION_MZONE)
	e4:SetHintTiming(0,TIMINGS_CHECK_MONSTER+TIMING_END_PHASE)
	e4:SetCountLimit(1,82090808)
	e4:SetCondition(c82090807.dhcon)
	e4:SetTarget(c82090807.dhtg)
	e4:SetOperation(c82090807.dhop)
	c:RegisterEffect(e4)
end
function c82090807.twofilter(c)
	return c:IsFaceup() and (c:IsLevel(2) or c:IsLink(2) or c:IsRank(2))
end
function c82090807.sprcon1(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c82090807.twofilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil)
end
function c82090807.sprcon2(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.GetLocationCount(1-tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c82090807.twofilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil)
end
function c82090807.actfilter(e,c)
	local g=c:GetLinkedGroup()
	return c:IsType(TYPE_LINK) and g:IsContains(e:GetHandler())
end
function c82090807.dhcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==1-tp
end
function c82090807.xfilter(c)
	return c:IsFaceup() and c:IsType(TYPE_XYZ) and c:GetOverlayCount()>0
end
function c82090807.dhtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c82090807.xfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c82090807.xfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,c82090807.xfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
end
function c82090807.dhop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:GetOverlayCount()>0 then
		tc:RemoveOverlayCard(tp,1,2,REASON_EFFECT)
	end
end
