--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: 星杯剑士 奥拉姆  (ID: 4709881)
-- Type: Monster / Effect / Link
-- Attribute: FIRE
-- Race: Cyberse
-- ATK 2000 | LINK
-- Setcode: 253
--
-- Effect Text:
-- 「星杯」怪兽2只
-- 这个卡名的②的效果1回合只能使用1次。
-- ①：这张卡的攻击力上升自己墓地的「星遗物」怪兽种类×300。
-- ②：把这张卡所连接区1只自己的「星杯」怪兽解放，以那只怪兽以外的自己墓地1只怪兽为对象才能发动。那只怪兽在作为这张卡所连接区的自己场上特殊召唤。
-- ③：这张卡从场上送去墓地的场合才能发动。从手卡把1只「星杯」怪兽特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--星杯剣士アウラム
function c4709881.initial_effect(c)
	--link summon
	aux.AddLinkProcedure(c,aux.FilterBoolFunction(Card.IsLinkSetCard,0xfd),2,2)
	c:EnableReviveLimit()
	--atkup
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetRange(LOCATION_MZONE)
	e1:SetValue(c4709881.atkval)
	c:RegisterEffect(e1)
	--spsummon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(4709881,0))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1,4709881)
	e2:SetCost(c4709881.spcost1)
	e2:SetTarget(c4709881.sptg1)
	e2:SetOperation(c4709881.spop1)
	c:RegisterEffect(e2)
	--spsummon
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(4709881,1))
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetProperty(EFFECT_FLAG_DELAY)
	e3:SetCode(EVENT_TO_GRAVE)
	e3:SetCondition(c4709881.spcon2)
	e3:SetTarget(c4709881.sptg2)
	e3:SetOperation(c4709881.spop2)
	c:RegisterEffect(e3)
end
function c4709881.atkfilter(c)
	return c:IsType(TYPE_MONSTER) and c:IsSetCard(0xfe)
end
function c4709881.atkval(e,c)
	return Duel.GetMatchingGroup(c4709881.atkfilter,c:GetControler(),LOCATION_GRAVE,0,nil):GetClassCount(Card.GetCode)*300
end
function c4709881.cfilter(c,g,tp,zone)
	return c:IsSetCard(0xfd) and g:IsContains(c)
		and Duel.GetMZoneCount(tp,c,tp,LOCATION_REASON_TOFIELD,zone)>0
end
function c4709881.spcost1(e,tp,eg,ep,ev,re,r,rp,chk)
	local lg=e:GetHandler():GetLinkedGroup()
	local zone=e:GetHandler():GetLinkedZone(tp)
	if chk==0 then return Duel.CheckReleaseGroup(tp,c4709881.cfilter,1,nil,lg,tp,zone) end
	local g=Duel.SelectReleaseGroup(tp,c4709881.cfilter,1,1,nil,lg,tp,zone)
	Duel.Release(g,REASON_COST)
	e:SetLabelObject(g:GetFirst())
end
function c4709881.spfilter1(c,e,tp)
	return c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c4709881.sptg1(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local cc=e:GetLabelObject()
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp)
		and chkc~=cc and c4709881.spfilter1(chkc,e,tp) end
	if chk==0 then return Duel.IsExistingTarget(c4709881.spfilter1,tp,LOCATION_GRAVE,0,1,cc,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c4709881.spfilter1,tp,LOCATION_GRAVE,0,1,1,cc,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function c4709881.spop1(e,tp,eg,ep,ev,re,r,rp)
	local zone=e:GetHandler():GetLinkedZone(tp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and zone&0x1f~=0 then
		Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP,zone)
	end
end
function c4709881.spcon2(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsPreviousLocation(LOCATION_ONFIELD)
end
function c4709881.spfilter2(c,e,tp)
	return c:IsSetCard(0xfd) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c4709881.sptg2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c4709881.spfilter2,tp,LOCATION_HAND,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND)
end
function c4709881.spop2(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c4709881.spfilter2,tp,LOCATION_HAND,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
