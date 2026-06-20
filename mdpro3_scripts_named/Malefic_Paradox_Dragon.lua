--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 罪 矛盾龙  (ID: 8310162)
-- Type: Monster / Effect / Synchro
-- Attribute: DARK
-- Race: Dragon
-- Level 10
-- ATK 4000 | DEF 4000
-- Setcode: 35
--
-- Effect Text:
-- 「罪 平行齿轮」＋调整以外的「罪」怪兽1只
-- ①：「罪 矛盾龙」在场上只能有1只表侧表示存在。
-- ②：这张卡同调召唤成功时，以自己或者对方的墓地1只同调怪兽为对象才能发动。那只怪兽在自己场上特殊召唤。
-- ③：场上没有「罪 世界」存在的场合这张卡破坏。
--[[ __CARD_HEADER_END__ ]]

--Sin パラドクス・ドラゴン
function c8310162.initial_effect(c)
	aux.AddCodeList(c,27564031)
	aux.AddMaterialCodeList(c,74509280)
	--synchro summon
	aux.AddSynchroProcedure(c,aux.FilterBoolFunction(Card.IsCode,74509280),aux.NonTuner(Card.IsSetCard,0x23),1,1)
	c:EnableReviveLimit()
	c:SetUniqueOnField(1,1,8310162)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(8310162,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCondition(c8310162.spcon)
	e1:SetTarget(c8310162.sptg)
	e1:SetOperation(c8310162.spop)
	c:RegisterEffect(e1)
	--selfdes
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetCode(EFFECT_SELF_DESTROY)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCondition(c8310162.descon)
	c:RegisterEffect(e2)
end
function c8310162.descon(e)
	return not Duel.IsEnvironment(27564031)
end
function c8310162.spcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsSummonType(SUMMON_TYPE_SYNCHRO) and e:GetHandler():IsLocation(LOCATION_MZONE)
end
function c8310162.spfilter(c,e,tp)
	return c:IsType(TYPE_SYNCHRO) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c8310162.sptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and c8310162.spfilter(chkc,e,tp) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingTarget(c8310162.spfilter,tp,LOCATION_GRAVE,LOCATION_GRAVE,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c8310162.spfilter,tp,LOCATION_GRAVE,LOCATION_GRAVE,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function c8310162.spop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
	end
end
