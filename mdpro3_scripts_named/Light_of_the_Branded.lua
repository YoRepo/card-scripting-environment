--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 烙印之光  (ID: 72554664)
-- Type: Spell / Continuous
-- ATK 0 | DEF 0
-- Setcode: 349
--
-- Effect Text:
-- 这个卡名的卡在1回合只能发动1张。
-- ①：以自己·对方的场上·墓地1只融合怪兽为对象才能发动。那只怪兽回到额外卡组。那之后，可以选自己墓地的「阿不思的落胤」和对方墓地的怪兽各1只在持有者场上特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--烙印の光
local s,id,o=GetID()
function s.initial_effect(c)
	aux.AddCodeList(c,68468459)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOEXTRA+CATEGORY_GRAVE_SPSUMMON+CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMINGS_CHECK_MONSTER+TIMING_END_PHASE)
	e1:SetCountLimit(1,id+EFFECT_COUNT_CODE_OATH)
	e1:SetTarget(s.target)
	e1:SetOperation(s.activate)
	c:RegisterEffect(e1)
end
function s.filter(c)
	return c:IsFaceupEx() and c:IsType(TYPE_FUSION) and c:IsAbleToExtra()
end
function s.spfilter1(c,e,tp)
	return c:IsCode(68468459)
		and Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function s.spfilter2(c,e,tp)
	return Duel.GetLocationCount(1-tp,LOCATION_MZONE,tp)>0
		and c:IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEUP,1-tp)
end
function s.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE+LOCATION_GRAVE) and s.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(s.filter,tp,LOCATION_MZONE+LOCATION_GRAVE,LOCATION_MZONE+LOCATION_GRAVE,1,nil,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g=Duel.SelectTarget(tp,s.filter,tp,LOCATION_MZONE+LOCATION_GRAVE,LOCATION_MZONE+LOCATION_GRAVE,1,1,nil,tp)
	Duel.SetOperationInfo(0,CATEGORY_TOEXTRA,g,1,0,0)
end
function s.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e)
		and Duel.SendtoDeck(tc,nil,SEQ_DECKSHUFFLE,REASON_EFFECT)~=0
		and tc:IsLocation(LOCATION_EXTRA) then
		local g1=Duel.GetMatchingGroup(aux.NecroValleyFilter(s.spfilter1),tp,LOCATION_GRAVE,0,nil,e,tp)
		local g2=Duel.GetMatchingGroup(aux.NecroValleyFilter(s.spfilter2),tp,0,LOCATION_GRAVE,nil,e,tp)
		if not Duel.IsPlayerAffectedByEffect(tp,59822133)
			and #g1>0 and #g2>0
			and Duel.SelectYesNo(tp,aux.Stringid(id,0)) then
			Duel.BreakEffect()
			Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(id,1))
			local sg1=g1:Select(tp,1,1,nil):GetFirst()
			Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(id,2))
			local sg2=g2:Select(tp,1,1,nil):GetFirst()
			Duel.SpecialSummonStep(sg1,0,tp,tp,false,false,POS_FACEUP)
			Duel.SpecialSummonStep(sg2,0,tp,1-tp,false,false,POS_FACEUP)
			Duel.SpecialSummonComplete()
		end
	end
end
