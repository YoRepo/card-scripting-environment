--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: 魔轰神 欧特罗  (ID: 49633574)
-- Type: Monster / Effect / Tuner
-- Attribute: LIGHT
-- Race: Fiend
-- Level 2
-- ATK 800 | DEF 500
-- Setcode: 53
--
-- Effect Text:
-- 把1张手卡送去墓地发动。从手卡把1只3星的名字带有「魔轰神」的怪兽特殊召唤。这个效果1回合只能使用1次。
--[[ __CARD_HEADER_END__ ]]

--魔轟神オルトロ
function c49633574.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(49633574,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetCountLimit(1)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCost(c49633574.cost)
	e1:SetTarget(c49633574.tg)
	e1:SetOperation(c49633574.op)
	c:RegisterEffect(e1)
end
function c49633574.cfilter(c,e,tp)
	return c:IsAbleToGraveAsCost() and Duel.IsExistingMatchingCard(c49633574.spfilter,tp,LOCATION_HAND,0,1,c,e,tp)
end
function c49633574.spfilter(c,e,tp)
	return c:IsSetCard(0x35) and c:IsLevel(3) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c49633574.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c49633574.cfilter,tp,LOCATION_HAND,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c49633574.cfilter,tp,LOCATION_HAND,0,1,1,nil,e,tp)
	Duel.SendtoGrave(g,REASON_COST)
end
function c49633574.tg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND)
end
function c49633574.op(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c49633574.spfilter,tp,LOCATION_HAND,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
