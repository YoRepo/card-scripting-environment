--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 先史遗产都市 巴比伦  (ID: 4357063)
-- Type: Spell / Counter
-- ATK 0 | DEF 0
-- Setcode: 112
--
-- Effect Text:
-- 1回合1次，把自己墓地1只名字带有「先史遗产」的怪兽从游戏中除外，从自己墓地选择持有和除外的怪兽相同等级的1只名字带有「先史遗产」的怪兽才能发动。选择的怪兽特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--先史遺産都市バビロン
function c4357063.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--spsummon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(4357063,0))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_FZONE)
	e2:SetCountLimit(1)
	e2:SetTarget(c4357063.sptg)
	e2:SetOperation(c4357063.spop)
	c:RegisterEffect(e2)
end
function c4357063.costfilter(c,e,tp)
	return c:IsSetCard(0x70) and c:IsAbleToRemoveAsCost() and c:GetLevel()>0
		and Duel.IsExistingTarget(c4357063.spfilter,tp,LOCATION_GRAVE,0,1,c,e,tp,c:GetLevel())
end
function c4357063.spfilter(c,e,tp,lv)
	return c:IsSetCard(0x70) and c:IsLevel(lv) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c4357063.sptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c4357063.spfilter(chkc,e,tp,e:GetLabel()) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c4357063.costfilter,tp,LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,c4357063.costfilter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
	local lv=g:GetFirst():GetLevel()
	Duel.Remove(g,POS_FACEUP,REASON_COST)
	e:SetLabel(lv)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c4357063.spfilter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp,lv)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function c4357063.spop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
	end
end
