--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 六武众之理  (ID: 27178262)
-- Type: Spell / Continuous
-- ATK 0 | DEF 0
-- Setcode: 4157
--
-- Effect Text:
-- 把自己场上表侧表示存在的1只名字带有「六武众」的怪兽送去墓地才能发动。选择自己或者对方的墓地1只名字带有「六武众」的怪兽在自己场上特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--六武衆の理
function c27178262.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c27178262.cost)
	e1:SetTarget(c27178262.target)
	e1:SetOperation(c27178262.activate)
	c:RegisterEffect(e1)
end
function c27178262.costfilter(c,ft)
	return c:IsFaceup() and c:IsSetCard(0x103d) and c:IsAbleToGraveAsCost() and (ft>0 or c:GetSequence()<5)
end
function c27178262.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	if chk==0 then return ft>-1 and Duel.IsExistingMatchingCard(c27178262.costfilter,tp,LOCATION_MZONE,0,1,nil,ft) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c27178262.costfilter,tp,LOCATION_MZONE,0,1,1,nil,ft)
	Duel.SendtoGrave(g,REASON_COST)
end
function c27178262.filter(c,e,tp)
	return c:IsSetCard(0x103d) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c27178262.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and c27178262.filter(chkc,e,tp) end
	if chk==0 then return Duel.IsExistingTarget(c27178262.filter,tp,LOCATION_GRAVE,LOCATION_GRAVE,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c27178262.filter,tp,LOCATION_GRAVE,LOCATION_GRAVE,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function c27178262.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
	end
end
