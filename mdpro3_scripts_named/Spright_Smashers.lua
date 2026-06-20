--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: 卫星闪灵粉碎者群集  (ID: 88836438)
-- Type: Spell / Continuous
-- ATK 0 | DEF 0
-- Setcode: 384
--
-- Effect Text:
-- 这个卡名的卡在1回合只能发动1张。
-- ①：可以从自己的手卡·墓地把「护宝炮妖」卡、「兽带斗神」卡、「卫星闪灵」卡的其中1张除外，从以下效果选择1个发动。
-- ●从卡组把1只「护宝炮妖」怪兽特殊召唤。
-- ●从自己墓地把1只「兽带斗神」怪兽特殊召唤。
-- ●自己场上1只2星·2阶·连接2的怪兽和对方场上1张卡除外。
--[[ __CARD_HEADER_END__ ]]

--スプライト・スマッシャーズ
function c88836438.initial_effect(c)
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(88836438,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,88836438+EFFECT_COUNT_CODE_OATH)
	e1:SetHintTiming(0,TIMINGS_CHECK_MONSTER+TIMING_END_PHASE)
	e1:SetCost(c88836438.cost)
	e1:SetTarget(c88836438.sptg1)
	e1:SetOperation(c88836438.spop1)
	c:RegisterEffect(e1)
	--spsummon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(88836438,1))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_ACTIVATE)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetCountLimit(1,88836438+EFFECT_COUNT_CODE_OATH)
	e2:SetHintTiming(0,TIMINGS_CHECK_MONSTER+TIMING_END_PHASE)
	e2:SetCost(c88836438.cost)
	e2:SetTarget(c88836438.sptg2)
	e2:SetOperation(c88836438.spop2)
	c:RegisterEffect(e2)
	--remove
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(88836438,2))
	e3:SetCategory(CATEGORY_REMOVE)
	e3:SetType(EFFECT_TYPE_ACTIVATE)
	e3:SetCode(EVENT_FREE_CHAIN)
	e3:SetCountLimit(1,88836438+EFFECT_COUNT_CODE_OATH)
	e3:SetHintTiming(0,TIMINGS_CHECK_MONSTER+TIMING_END_PHASE)
	e3:SetCost(c88836438.cost)
	e3:SetTarget(c88836438.rmtg)
	e3:SetOperation(c88836438.rmop)
	c:RegisterEffect(e3)
end
function c88836438.cfilter(c)
	return c:IsSetCard(0x155,0x179,0x180) and c:IsAbleToRemoveAsCost()
end
function c88836438.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c88836438.cfilter,tp,LOCATION_HAND+LOCATION_GRAVE,0,1,e:GetHandler()) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,c88836438.cfilter,tp,LOCATION_HAND+LOCATION_GRAVE,0,1,1,nil)
	Duel.Remove(g,POS_FACEUP,REASON_COST)
end
function c88836438.spfilter1(c,e,tp)
	return c:IsSetCard(0x155) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c88836438.sptg1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c88836438.spfilter1,tp,LOCATION_DECK,0,1,nil,e,tp) end
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c88836438.spop1(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c88836438.spfilter1,tp,LOCATION_DECK,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
function c88836438.spfilter2(c,e,tp)
	return c:IsSetCard(0x179) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c88836438.sptg2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c88836438.spfilter2,tp,LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_GRAVE)
end
function c88836438.spop2(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,aux.NecroValleyFilter(c88836438.spfilter2),tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
function c88836438.rmfilter(c)
	return (c:IsLevel(2) or c:IsRank(2) or c:IsLink(2)) and c:IsFaceup() and c:IsAbleToRemove()
end
function c88836438.rmtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c88836438.rmfilter,tp,LOCATION_MZONE,0,1,nil)
		and Duel.IsExistingMatchingCard(Card.IsAbleToRemove,tp,0,LOCATION_ONFIELD,1,nil,tp) end
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,nil,2,PLAYER_ALL,LOCATION_ONFIELD)
end
function c88836438.rmop(e,tp,eg,ep,ev,re,r,rp)
	if not c88836438.rmtg(e,tp,eg,ep,ev,re,r,rp,0) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g1=Duel.SelectMatchingCard(tp,c88836438.rmfilter,tp,LOCATION_MZONE,0,1,1,nil)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g2=Duel.SelectMatchingCard(tp,Card.IsAbleToRemove,tp,0,LOCATION_ONFIELD,1,1,nil,tp)
	g1:Merge(g2)
	Duel.HintSelection(g1)
	Duel.Remove(g1,POS_FACEUP,REASON_EFFECT)
end
