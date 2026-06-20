--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 水精鳞-深渊蒂妮  (ID: 74298287)
-- Type: Monster / Effect
-- Attribute: WATER
-- Race: Aqua
-- Level 3
-- ATK 1000 | DEF 200
-- Setcode: 7667828
--
-- Effect Text:
-- 自己场上有名字带有「水精鳞」的怪兽存在的场合，这张卡用卡的效果从卡组或者墓地加入手卡时，这张卡可以从手卡特殊召唤。此外，这张卡用名字带有「水精鳞」的怪兽的效果特殊召唤成功时，可以从自己墓地选择1只3星
-- 以下的名字带有「水精鳞」的怪兽特殊召唤。「水精鳞-深渊蒂妮」的效果1回合只能使用1次。
--[[ __CARD_HEADER_END__ ]]

--水精鱗－アビスディーネ
function c74298287.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(74298287,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_TO_HAND)
	e1:SetCountLimit(1,74298287)
	e1:SetCondition(c74298287.spcon1)
	e1:SetTarget(c74298287.sptg1)
	e1:SetOperation(c74298287.spop1)
	c:RegisterEffect(e1)
	--
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(74298287,0))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DAMAGE_STEP)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetCountLimit(1,74298287)
	e2:SetCondition(c74298287.spcon2)
	e2:SetTarget(c74298287.sptg2)
	e2:SetOperation(c74298287.spop2)
	c:RegisterEffect(e2)
end
function c74298287.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x74)
end
function c74298287.spcon1(e,tp,eg,ep,ev,re,r,rp)
	return bit.band(r,REASON_EFFECT)~=0 and e:GetHandler():IsPreviousLocation(LOCATION_DECK+LOCATION_GRAVE)
		and Duel.IsExistingMatchingCard(c74298287.cfilter,tp,LOCATION_MZONE,0,1,nil)
end
function c74298287.sptg1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsRelateToEffect(e) and Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c74298287.spop1(e,tp,eg,ep,ev,re,r,rp)
	if not Duel.IsExistingMatchingCard(c74298287.cfilter,tp,LOCATION_MZONE,0,1,nil) then return end
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
end
function c74298287.spcon2(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:GetSpecialSummonInfo(SUMMON_INFO_TYPE)&TYPE_MONSTER~=0 and c:IsSpecialSummonSetCard(0x74)
end
function c74298287.spfilter(c,e,tp)
	return c:IsSetCard(0x74) and c:IsLevelBelow(3) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c74298287.sptg2(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c74298287.spfilter(chkc,e,tp) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingTarget(c74298287.spfilter,tp,LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c74298287.spfilter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function c74298287.spop2(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
	end
end
