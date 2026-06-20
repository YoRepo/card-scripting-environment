--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:37
-- Card: 暗岩的海龙神  (ID: 95602345)
-- Type: Trap
-- ATK 0 | DEF 0
-- Setcode: 375
--
-- Effect Text:
-- 这个卡名的卡在1回合只能发动1张。
-- ①：把自己场上1张表侧表示的「海」送去墓地才能发动。从自己的手卡·卡组把有「海」的卡名记述的怪兽或者水属性通常怪兽合计最多2只守备表示特殊召唤（同名卡最多1张）。对方场上有怪兽存在的场合，可以再从手卡
-- ·卡组把6星以下的水属性通常怪兽任意数量特殊召唤。这张卡的发动后，直到下次的自己回合的结束时自己不是水属性怪兽不能特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--暗岩の海竜神
function c95602345.initial_effect(c)
	aux.AddCodeList(c,22702055)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,95602345+EFFECT_COUNT_CODE_OATH)
	e1:SetHintTiming(0,TIMING_END_PHASE)
	e1:SetCost(c95602345.cost)
	e1:SetTarget(c95602345.target)
	e1:SetOperation(c95602345.activate)
	c:RegisterEffect(e1)
end
function c95602345.cfilter(c)
	return c:IsCode(22702055) and c:IsAbleToGraveAsCost() and c:IsFaceup()
end
function c95602345.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c95602345.cfilter,tp,LOCATION_ONFIELD,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c95602345.cfilter,tp,LOCATION_ONFIELD,0,1,1,nil)
	Duel.SendtoGrave(g,REASON_COST)
end
function c95602345.spfilter(c,e,tp)
	return (aux.IsCodeListed(c,22702055) or (c:IsType(TYPE_NORMAL) and c:IsAttribute(ATTRIBUTE_WATER)))
		and c:IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEUP_DEFENSE)
end
function c95602345.spfilter1(c,e,tp)
	return c:IsType(TYPE_NORMAL) and c:IsAttribute(ATTRIBUTE_WATER) and c:IsLevelBelow(6) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c95602345.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c95602345.spfilter,tp,LOCATION_HAND+LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND+LOCATION_DECK)
end
function c95602345.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local ft=math.min(2,(Duel.GetLocationCount(tp,LOCATION_MZONE)))
	if ft>0 then
		if Duel.IsPlayerAffectedByEffect(tp,59822133) then ft=1 end
		local tg=Duel.GetMatchingGroup(c95602345.spfilter,tp,LOCATION_HAND+LOCATION_DECK,0,nil,e,tp)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local g1=tg:SelectSubGroup(tp,aux.dncheck,false,1,ft)
		if g1 then
			Duel.SpecialSummon(g1,0,tp,tp,false,false,POS_FACEUP_DEFENSE)
		end
		local ft1=Duel.GetLocationCount(tp,LOCATION_MZONE)
		local g2=Duel.GetMatchingGroup(c95602345.spfilter1,tp,LOCATION_HAND+LOCATION_DECK,0,nil,e,tp)
		if ft1>1 and Duel.IsPlayerAffectedByEffect(tp,59822133) then ft=1 end
		if ft1>0 and Duel.IsExistingMatchingCard(nil,tp,0,LOCATION_MZONE,1,nil)
			and #g2>0 and Duel.SelectYesNo(tp,aux.Stringid(95602345,0)) then
			Duel.BreakEffect()
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
			local g3=g2:Select(tp,1,ft1,nil)
			if g3 then
				Duel.SpecialSummon(g3,0,tp,tp,false,false,POS_FACEUP)
			end
		end
	end
	if e:IsHasType(EFFECT_TYPE_ACTIVATE) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_FIELD)
		e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
		e1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
		e1:SetTargetRange(1,0)
		e1:SetTarget(c95602345.splimit)
		if Duel.GetTurnPlayer()==tp then
			e1:SetReset(RESET_PHASE+PHASE_END+RESET_SELF_TURN,2)
		else
			e1:SetReset(RESET_PHASE+PHASE_END+RESET_SELF_TURN,1)
		end
		Duel.RegisterEffect(e1,tp)
	end
end
function c95602345.splimit(e,c)
	return not c:IsAttribute(ATTRIBUTE_WATER)
end
