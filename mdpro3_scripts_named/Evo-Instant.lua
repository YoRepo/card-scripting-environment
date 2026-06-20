--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 突然进化  (ID: 24362891)
-- Type: Trap
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 把自己场上1只爬虫类族怪兽解放才能发动。从卡组把1只名字带有「进化龙」的怪兽特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--突然進化
function c24362891.initial_effect(c)
	--Special Summon
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMING_END_PHASE)
	e1:SetCost(c24362891.cost)
	e1:SetTarget(c24362891.target)
	e1:SetOperation(c24362891.operation)
	c:RegisterEffect(e1)
end
function c24362891.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	e:SetLabel(1)
	if chk==0 then return Duel.CheckReleaseGroup(tp,Card.IsRace,1,nil,RACE_REPTILE) end
	local g=Duel.SelectReleaseGroup(tp,Card.IsRace,1,1,nil,RACE_REPTILE)
	Duel.Release(g,REASON_COST)
end
function c24362891.filter(c,e,tp)
	return c:IsSetCard(0x604e) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c24362891.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		if e:GetLabel()==0 and Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return false end
		e:SetLabel(0)
		return Duel.IsExistingMatchingCard(c24362891.filter,tp,LOCATION_DECK,0,1,nil,e,tp)
	end
	e:SetLabel(0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c24362891.operation(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c24362891.filter,tp,LOCATION_DECK,0,1,1,nil,e,tp)
	Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
end
