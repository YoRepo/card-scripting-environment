--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 木天蓼仙狸  (ID: 13382806)
-- Type: Monster / Effect
-- Attribute: WIND
-- Race: Beast
-- Level 2
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 这个卡名的效果1回合只能使用1次。
-- ①：把这张卡解放，以「木天蓼仙狸」以外的自己墓地1只2星怪兽为对象才能发动。那只怪兽特殊召唤。那之后，可以把和这个效果特殊召唤的怪兽属性不同的1只2星怪兽从手卡特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--マタタビ仙狸
function c13382806.initial_effect(c)
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCountLimit(1,13382806)
	e1:SetCost(c13382806.cost)
	e1:SetTarget(c13382806.target)
	e1:SetOperation(c13382806.operation)
	c:RegisterEffect(e1)
end
function c13382806.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsReleasable() end
	Duel.Release(e:GetHandler(),REASON_COST)
end
function c13382806.spfilter(c,e,tp)
	return c:IsCanBeSpecialSummoned(e,0,tp,false,false) and c:IsLevel(2) and not c:IsCode(13382806)
end
function c13382806.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c13382806.spfilter(chkc,e,tp) end
	if chk==0 then return Duel.GetMZoneCount(tp,e:GetHandler())>0
		and Duel.IsExistingTarget(c13382806.spfilter,tp,LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c13382806.spfilter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function c13382806.spfilter2(c,e,tp,attr)
	return c:IsCanBeSpecialSummoned(e,0,tp,false,false) and c:IsLevel(2) and not c:IsAttribute(attr)
end
function c13382806.operation(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)>0
		and Duel.IsExistingMatchingCard(c13382806.spfilter2,tp,LOCATION_HAND,0,1,nil,e,tp,tc:GetAttribute())
		and Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and Duel.SelectYesNo(tp,aux.Stringid(13382806,0)) then
		Duel.BreakEffect()
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local sg=Duel.SelectMatchingCard(tp,c13382806.spfilter2,tp,LOCATION_HAND,0,1,1,nil,e,tp,tc:GetAttribute())
		Duel.SpecialSummon(sg,0,tp,tp,false,false,POS_FACEUP)
	end
end
