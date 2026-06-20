--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 魊影宇宙  (ID: 38409239)
-- Type: Trap
-- ATK 0 | DEF 0
-- Setcode: 394
--
-- Effect Text:
-- 这个卡名的卡在1回合只能发动1张。
-- ①：除外状态的鱼族怪兽数量的以下效果各适用。
-- ●1只以上：这个回合，自己的鱼族怪兽不会被战斗破坏。
-- ●4只以上：这个回合，自己场上的鱼族怪兽的效果的发动以及那些发动的效果不会被无效化。
-- ●8只以上：从额外卡组把1只鱼族同调怪兽当作同调召唤作特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--ゴーティス・コスモス
local s,id,o=GetID()
function s.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMINGS_CHECK_MONSTER)
	e1:SetCountLimit(1,id+EFFECT_COUNT_CODE_OATH)
	e1:SetTarget(s.target)
	e1:SetOperation(s.activate)
	c:RegisterEffect(e1)
end
function s.cfilter(c)
	return c:IsFaceup() and c:IsRace(RACE_FISH)
end
function s.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local ct=Duel.GetMatchingGroupCount(s.cfilter,tp,LOCATION_REMOVED,LOCATION_REMOVED,nil)
	if chk==0 then return ct>0
		and (ct<8 or aux.MustMaterialCheck(nil,tp,EFFECT_MUST_BE_SMATERIAL)
			and Duel.IsExistingMatchingCard(s.filter,tp,LOCATION_EXTRA,0,1,nil,e,tp)) end
	if ct>=8 then
		Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
	end
end
function s.filter(c,e,tp)
	return c:IsType(TYPE_SYNCHRO) and c:IsRace(RACE_FISH)
		and c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_SYNCHRO,tp,false,false)
		and Duel.GetLocationCountFromEx(tp,tp,nil,c)>0
end
function s.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local ct=Duel.GetMatchingGroupCount(s.cfilter,tp,LOCATION_REMOVED,LOCATION_REMOVED,nil)
	if ct>0 then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_FIELD)
		e1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
		e1:SetTargetRange(LOCATION_MZONE,0)
		e1:SetTarget(aux.TargetBoolFunction(Card.IsRace,RACE_FISH))
		e1:SetReset(RESET_PHASE+PHASE_END)
		e1:SetValue(1)
		Duel.RegisterEffect(e1,tp)
		Duel.BreakEffect()
	end
	if ct>3 then
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_FIELD)
		e2:SetCode(EFFECT_CANNOT_INACTIVATE)
		e2:SetTargetRange(LOCATION_MZONE,0)
		e2:SetReset(RESET_PHASE+PHASE_END)
		e2:SetValue(s.efilter)
		Duel.RegisterEffect(e2,tp)
		local e3=e2:Clone()
		e3:SetCode(EFFECT_CANNOT_DISEFFECT)
		Duel.RegisterEffect(e3,tp)
		Duel.BreakEffect()
	end
	if ct>7 and aux.MustMaterialCheck(nil,tp,EFFECT_MUST_BE_SMATERIAL)
		and Duel.IsExistingMatchingCard(s.filter,tp,LOCATION_EXTRA,0,1,nil,e,tp) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local tc=Duel.SelectMatchingCard(tp,s.filter,tp,LOCATION_EXTRA,0,1,1,nil,e,tp):GetFirst()
		tc:SetMaterial(nil)
		if Duel.SpecialSummon(tc,SUMMON_TYPE_SYNCHRO,tp,tp,false,false,POS_FACEUP)>0 then
			tc:CompleteProcedure()
		end
	end
end
function s.efilter(e,ct)
	local p=e:GetHandlerPlayer()
	local te,tp,loc=Duel.GetChainInfo(ct,CHAININFO_TRIGGERING_EFFECT,CHAININFO_TRIGGERING_PLAYER,CHAININFO_TRIGGERING_LOCATION)
	return p==tp and te:IsActiveType(TYPE_MONSTER) and te:GetHandler():IsRace(RACE_FISH) and loc&LOCATION_MZONE>0
end
