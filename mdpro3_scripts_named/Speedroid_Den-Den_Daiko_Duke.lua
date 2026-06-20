--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:31
-- Card: 疾行机人 电电大公  (ID: 59640711)
-- Type: Monster / Effect / Tuner
-- Attribute: WIND
-- Race: Machine
-- Level 3
-- ATK 1000 | DEF 1000
-- Setcode: 8214
--
-- Effect Text:
-- 这个卡名的效果1回合只能使用1次。
-- ①：把墓地的这张卡除外才能发动。从自己的手卡·墓地选「疾行机人 电电大公」以外的1只「疾行机人」调整特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--SR電々大公
function c59640711.initial_effect(c)
	--destroy
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_GRAVE)
	e1:SetCountLimit(1,59640711)
	e1:SetCost(aux.bfgcost)
	e1:SetTarget(c59640711.sptg)
	e1:SetOperation(c59640711.spop)
	c:RegisterEffect(e1)
end
function c59640711.spfilter(c,e,tp)
	return c:IsSetCard(0x2016) and c:IsType(TYPE_TUNER) and not c:IsCode(59640711) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c59640711.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c59640711.spfilter,tp,LOCATION_HAND+LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND+LOCATION_GRAVE)
end
function c59640711.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,aux.NecroValleyFilter(c59640711.spfilter),tp,LOCATION_HAND+LOCATION_GRAVE,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
