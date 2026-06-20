--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:26
-- Card: 命运标记  (ID: 35464895)
-- Type: Trap
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 自己场上的怪兽被战斗破坏送去墓地时才能发动。从自己的手卡·卡组特殊召唤1只名字带有「命运英雄」的4星以下的怪兽。
--[[ __CARD_HEADER_END__ ]]

--デステニー・シグナル
function c35464895.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetCode(EVENT_BATTLE_DESTROYED)
	e1:SetCondition(c35464895.condition)
	e1:SetTarget(c35464895.target)
	e1:SetOperation(c35464895.operation)
	c:RegisterEffect(e1)
end
function c35464895.cfilter(c,tp)
	return c:IsReason(REASON_BATTLE) and c:IsLocation(LOCATION_GRAVE) and c:IsPreviousControler(tp)
end
function c35464895.condition(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c35464895.cfilter,1,nil,tp)
end
function c35464895.spfilter(c,e,tp)
	return c:IsLevelBelow(4) and c:IsSetCard(0xc008) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c35464895.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c35464895.spfilter,tp,LOCATION_HAND+LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND+LOCATION_DECK)
end
function c35464895.operation(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c35464895.spfilter,tp,LOCATION_HAND+LOCATION_DECK,0,1,1,nil,e,tp)
	if g:GetCount()~=0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
