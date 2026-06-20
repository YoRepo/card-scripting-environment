--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 原始生命态 尼比鲁  (ID: 27204311)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Rock
-- Level 11
-- ATK 3000 | DEF 600
--
-- Effect Text:
-- 这个卡名的效果1回合只能使用1次。
-- ①：对方把5只以上的怪兽召唤·特殊召唤的自己·对方回合的主要阶段才能发动。自己·对方场上的表侧表示怪兽尽可能解放，这张卡从手卡特殊召唤。那之后，在对方场上把1只「原始生命态衍生物」（岩石族·光·11星
-- ·攻/守?）特殊召唤。这衍生物的攻击力·守备力变成这个效果解放的怪兽的原本的攻击力·守备力各自合计数值。
--[[ __CARD_HEADER_END__ ]]

--原始生命態ニビル
function c27204311.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(27204311,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOKEN)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMINGS_CHECK_MONSTER+TIMING_MAIN_END)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,27204311)
	e1:SetCondition(c27204311.spcon)
	e1:SetTarget(c27204311.sptg)
	e1:SetOperation(c27204311.spop)
	c:RegisterEffect(e1)
	if not c27204311.global_check then
		c27204311.global_check=true
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetCode(EVENT_SUMMON_SUCCESS)
		ge1:SetOperation(c27204311.checkop)
		Duel.RegisterEffect(ge1,0)
		local ge2=ge1:Clone()
		ge2:SetCode(EVENT_SPSUMMON_SUCCESS)
		Duel.RegisterEffect(ge2,0)
	end
end
function c27204311.checkop(e,tp,eg,ep,ev,re,r,rp)
	local tc=eg:GetFirst()
	while tc do
		Duel.RegisterFlagEffect(tc:GetSummonPlayer(),27204311,RESET_PHASE+PHASE_END,0,1)
		tc=eg:GetNext()
	end
end
function c27204311.spcon(e,tp,eg,ep,ev,re,r,rp)
	if Duel.IsPlayerAffectedByEffect(tp,EFFECT_KAISER_COLOSSEUM) then
		local t1=Duel.GetFieldGroupCount(tp,LOCATION_MZONE,0)
		local t2=Duel.GetFieldGroupCount(tp,0,LOCATION_MZONE)
		local c1=Duel.GetMatchingGroupCount(c27204311.relfilter,tp,LOCATION_MZONE,0,nil)
		local c2=Duel.GetMatchingGroupCount(c27204311.relfilter,tp,0,LOCATION_MZONE,nil)
		if t1-c1 >= t2-c2 then return false end
	end
	return Duel.GetFlagEffect(1-tp,27204311)>=5 and (Duel.GetCurrentPhase()==PHASE_MAIN1 or Duel.GetCurrentPhase()==PHASE_MAIN2)
end
function c27204311.relfilter(c)
	return c:IsFaceup() and c:IsReleasableByEffect()
end
function c27204311.adfilter(c,f)
	return math.max(f(c),0)
end
function c27204311.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local g=Duel.GetMatchingGroup(Card.IsFaceup,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	if chk==0 then return g:GetCount()>0 and Duel.GetMZoneCount(tp,g)>0 and Duel.GetMZoneCount(1-tp,g,tp)>0
		and Duel.IsPlayerCanRelease(tp)
		and Duel.IsPlayerCanSpecialSummonCount(tp,2)
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false)
		and Duel.IsPlayerCanSpecialSummonMonster(tp,27204312,0,TYPES_TOKEN_MONSTER,g:GetSum(c27204311.adfilter,Card.GetTextAttack),g:GetSum(c27204311.adfilter,Card.GetTextDefense),11,RACE_ROCK,ATTRIBUTE_LIGHT,POS_FACEUP,1-tp) end
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),2,0,0)
end
function c27204311.spop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c27204311.relfilter,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	if g:GetCount()>0 and Duel.Release(g,REASON_EFFECT)~=0 then
		local og=Duel.GetOperatedGroup()
		local c=e:GetHandler()
		if c:IsRelateToEffect(e) and Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)>0 then
			if og:GetCount()==0 then return end
			local atk=og:GetSum(c27204311.adfilter,Card.GetTextAttack)
			local def=og:GetSum(c27204311.adfilter,Card.GetTextDefense)
			if Duel.GetLocationCount(1-tp,LOCATION_MZONE,tp)>0
				and Duel.IsPlayerCanSpecialSummonMonster(tp,27204312,0,TYPES_TOKEN_MONSTER,atk,def,11,RACE_ROCK,ATTRIBUTE_LIGHT,POS_FACEUP,1-tp) then
				Duel.BreakEffect()
				local token=Duel.CreateToken(tp,27204312)
				local e1=Effect.CreateEffect(c)
				e1:SetType(EFFECT_TYPE_SINGLE)
				e1:SetCode(EFFECT_SET_ATTACK)
				e1:SetValue(atk)
				e1:SetReset(RESET_EVENT+RESETS_STANDARD-RESET_TOFIELD)
				token:RegisterEffect(e1)
				local e2=Effect.CreateEffect(c)
				e2:SetType(EFFECT_TYPE_SINGLE)
				e2:SetCode(EFFECT_SET_DEFENSE)
				e2:SetValue(def)
				e2:SetReset(RESET_EVENT+RESETS_STANDARD-RESET_TOFIELD)
				token:RegisterEffect(e2)
				Duel.SpecialSummon(token,0,tp,1-tp,false,false,POS_FACEUP)
			end
		end
	end
end
