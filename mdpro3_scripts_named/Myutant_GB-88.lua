--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 被检体 秘异三变体GB-88  (ID: 43709490)
-- Type: Monster / Effect
-- Attribute: WATER
-- Race: Psychic
-- Level 4
-- ATK 500 | DEF 500
-- Setcode: 343
--
-- Effect Text:
-- 这个卡名的①②的效果1回合各能使用1次。
-- ①：自己的场地区域有「秘异三变体进化研究所」存在的场合，对方主要阶段才能发动。这张卡从手卡特殊召唤。
-- ②：对方回合，这张卡特殊召唤成功的场合，把这张卡解放，把1张手卡或者自己场上的表侧表示的卡除外才能发动。从自己墓地的怪兽以及除外的自己怪兽之中选1只8星「秘异三变」怪兽特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--被検体ミュートリアGB－88
function c43709490.initial_effect(c)
	aux.AddCodeList(c,34572613)
	--self spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(43709490,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,43709490)
	e1:SetHintTiming(0,TIMINGS_CHECK_MONSTER+TIMING_MAIN_END)
	e1:SetCondition(c43709490.spcon)
	e1:SetTarget(c43709490.sptg)
	e1:SetOperation(c43709490.spop)
	c:RegisterEffect(e1)
	--spsummon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(43709490,1))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetCountLimit(1,43709491)
	e2:SetCondition(c43709490.sp2con)
	e2:SetCost(c43709490.sp2cost)
	e2:SetTarget(c43709490.sp2tg)
	e2:SetOperation(c43709490.sp2op)
	c:RegisterEffect(e2)
end
function c43709490.spcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsEnvironment(34572613,tp,LOCATION_FZONE) and Duel.GetTurnPlayer()~=tp
		and (Duel.GetCurrentPhase()==PHASE_MAIN1 or Duel.GetCurrentPhase()==PHASE_MAIN2)
end
function c43709490.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:IsCanBeSpecialSummoned(e,0,tp,false,false)
		and Duel.GetMZoneCount(tp)>0 end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,c,1,0,0)
end
function c43709490.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
end
function c43709490.sp2con(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()~=tp
end
function c43709490.sp2costfilter(c,tp,tc)
	local tg=Group.FromCards(c,tc)
	return c:IsAbleToRemoveAsCost() and (c:IsFaceup() or c:IsLocation(LOCATION_HAND))
		and Duel.GetMZoneCount(tp,tg)>0
end
function c43709490.sp2cost(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:IsReleasable()
		and Duel.IsExistingMatchingCard(c43709490.sp2costfilter,tp,LOCATION_HAND+LOCATION_ONFIELD,0,1,c,tp,c) end
	Duel.Release(c,REASON_COST)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local cost=Duel.SelectMatchingCard(tp,c43709490.sp2costfilter,tp,LOCATION_HAND+LOCATION_ONFIELD,0,1,1,c,tp,c)
	Duel.Remove(cost,POS_FACEUP,REASON_COST)
end
function c43709490.sp2tgfilter(c,e,tp)
	return c:IsCanBeSpecialSummoned(e,0,tp,false,false)
		and c:IsSetCard(0x157) and c:IsLevel(8) and (c:IsFaceup() or c:IsLocation(LOCATION_GRAVE))
end
function c43709490.sp2tg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c43709490.sp2tgfilter,tp,LOCATION_GRAVE+LOCATION_REMOVED,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_GRAVE+LOCATION_REMOVED)
end
function c43709490.sp2op(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local tc=Duel.SelectMatchingCard(tp,aux.NecroValleyFilter(c43709490.sp2tgfilter),tp,LOCATION_GRAVE+LOCATION_REMOVED,0,1,1,nil,e,tp)
	if tc then Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP) end
end
