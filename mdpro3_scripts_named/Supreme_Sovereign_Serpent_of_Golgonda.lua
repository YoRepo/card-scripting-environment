--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:26
-- Card: 霸蛇大公 戈尔工达  (ID: 31042659)
-- Type: Monster / Effect
-- Attribute: FIRE
-- Race: Reptile
-- Level 8
-- ATK ? | DEF 0
--
-- Effect Text:
-- 这个卡名的①③的效果1回合各能使用1次。
-- ①：这张卡在手卡·墓地存在，自己的场地区域有表侧表示卡存在的场合才能发动。这张卡特殊召唤。这个效果特殊召唤的这张卡从场上离开的场合除外。
-- ②：只要场上有「大沙海 黄金戈尔工达」存在，这张卡的原本攻击力变成3000。
-- ③：场上的「大沙海 黄金戈尔工达」被效果破坏的场合，可以作为代替把自己墓地1只怪兽除外。
--[[ __CARD_HEADER_END__ ]]

--覇蛇大公ゴルゴンダ
function c31042659.initial_effect(c)
	aux.AddCodeList(c,60884672)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(31042659,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_HAND+LOCATION_GRAVE)
	e1:SetCountLimit(1,31042659)
	e1:SetCondition(c31042659.spcon)
	e1:SetTarget(c31042659.sptg)
	e1:SetOperation(c31042659.spop)
	c:RegisterEffect(e1)
	--destroy replace
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_DESTROY_REPLACE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1,31042660)
	e2:SetTarget(c31042659.reptg)
	e2:SetValue(c31042659.repval)
	c:RegisterEffect(e2)
	--original ATK
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCode(EFFECT_SET_BASE_ATTACK)
	e3:SetCondition(c31042659.atkcon)
	e3:SetValue(3000)
	c:RegisterEffect(e3)
end
function c31042659.spcon(e)
	return Duel.IsExistingMatchingCard(Card.IsFaceup,e:GetHandlerPlayer(),LOCATION_FZONE,0,1,nil)
end
function c31042659.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c31042659.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)~=0 then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_LEAVE_FIELD_REDIRECT)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetReset(RESET_EVENT+RESETS_REDIRECT)
		e1:SetValue(LOCATION_REMOVED)
		c:RegisterEffect(e1,true)
	end
end
function c31042659.repfilter(c)
	return c:IsFaceup() and c:IsCode(60884672) and c:IsReason(REASON_EFFECT) and not c:IsReason(REASON_REPLACE)
end
function c31042659.rmfilter(c)
	return c:IsType(TYPE_MONSTER) and c:IsAbleToRemove()
end
function c31042659.reptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return eg:IsExists(c31042659.repfilter,1,nil)
		and Duel.IsExistingMatchingCard(c31042659.rmfilter,tp,LOCATION_GRAVE,0,1,nil) end
	if Duel.SelectEffectYesNo(tp,e:GetHandler(),96) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
		local g=Duel.SelectMatchingCard(tp,c31042659.rmfilter,tp,LOCATION_GRAVE,0,1,1,nil)
		Duel.Remove(g,POS_FACEUP,REASON_EFFECT+REASON_REPLACE)
		return true
	end
	return false
end
function c31042659.repval(e,c)
	return c31042659.repfilter(c)
end
function c31042659.atkcon(e)
	return Duel.IsEnvironment(60884672)
end
