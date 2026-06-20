--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 充电池人  (ID: 83446909)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Thunder
-- Level 5
-- ATK 1800 | DEF 1200
-- Setcode: 40
--
-- Effect Text:
-- 这张卡的召唤成功时，可以从自己的手卡·卡组把1只「充电池人」以外的名字带有「电池人」的怪兽特殊召唤。这张卡的攻击力·守备力上升自己场上表侧表示存在的雷族怪兽数量×300的数值。
--[[ __CARD_HEADER_END__ ]]

--充電池メン
function c83446909.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(83446909,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetTarget(c83446909.sumtg)
	e1:SetOperation(c83446909.sumop)
	c:RegisterEffect(e1)
	--atk,def
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetValue(c83446909.val)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EFFECT_UPDATE_DEFENSE)
	c:RegisterEffect(e3)
end
function c83446909.spfilter(c,e,tp)
	return not c:IsCode(83446909) and c:IsSetCard(0x28) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c83446909.sumtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c83446909.spfilter,tp,LOCATION_HAND+LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND+LOCATION_DECK)
end
function c83446909.sumop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c83446909.spfilter,tp,LOCATION_HAND+LOCATION_DECK,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
function c83446909.filter(c)
	return c:IsFaceup() and c:IsRace(RACE_THUNDER)
end
function c83446909.val(e,c)
	return Duel.GetMatchingGroupCount(c83446909.filter,c:GetControler(),LOCATION_MZONE,0,nil)*300
end
