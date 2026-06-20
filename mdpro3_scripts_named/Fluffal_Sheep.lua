--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:37
-- Card: 毛绒动物·绵羊  (ID: 98280324)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Fairy
-- Level 2
-- ATK 400 | DEF 800
-- Setcode: 169
--
-- Effect Text:
-- 「毛绒动物·绵羊」的②的效果1回合只能使用1次。
-- ①：自己场上有「毛绒动物·绵羊」以外的「毛绒动物」怪兽存在的场合，这张卡可以从手卡特殊召唤。
-- ②：让这张卡以外的自己场上1只「毛绒动物」怪兽回到持有者手卡才能发动。从自己的手卡·墓地选1只「锋利小鬼」怪兽特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--ファーニマル・シープ
function c98280324.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c98280324.spcon)
	c:RegisterEffect(e1)
	--spsummon
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1,98280324)
	e2:SetCost(c98280324.spcost)
	e2:SetTarget(c98280324.sptg)
	e2:SetOperation(c98280324.spop)
	c:RegisterEffect(e2)
end
function c98280324.filter(c)
	return c:IsFaceup() and c:IsSetCard(0xa9) and not c:IsCode(98280324)
end
function c98280324.spcon(e,c)
	if c==nil then return true end
	return Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c98280324.filter,c:GetControler(),LOCATION_MZONE,0,1,nil)
end
function c98280324.cfilter(c,ft)
	return c:IsFaceup() and c:IsSetCard(0xa9) and c:IsAbleToHandAsCost() and (ft>0 or c:GetSequence()<5)
end
function c98280324.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	if chk==0 then return ft>-1 and Duel.IsExistingMatchingCard(c98280324.cfilter,tp,LOCATION_MZONE,0,1,e:GetHandler(),ft) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RTOHAND)
	local g=Duel.SelectMatchingCard(tp,c98280324.cfilter,tp,LOCATION_MZONE,0,1,1,e:GetHandler(),ft)
	Duel.SendtoHand(g,nil,REASON_COST)
end
function c98280324.spfilter(c,e,tp)
	return c:IsSetCard(0xc3) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c98280324.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c98280324.spfilter,tp,LOCATION_HAND+LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND+LOCATION_GRAVE)
end
function c98280324.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,aux.NecroValleyFilter(c98280324.spfilter),tp,LOCATION_HAND+LOCATION_GRAVE,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
