--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: 不屈的兽仆  (ID: 8700633)
-- Type: Monster / Effect
-- Attribute: FIRE
-- Race: Beast
-- Level 2
-- ATK 900 | DEF 2000
--
-- Effect Text:
-- 这个卡名的①的效果1回合只能使用1次。
-- ①：对方把3只以上的怪兽特殊召唤的回合的主要阶段才能发动。这张卡从手卡·墓地特殊召唤。这个效果在对方回合也能发动。
-- ②：自己场上没有其他怪兽存在的场合，攻击表示的这张卡不会被战斗破坏。
--[[ __CARD_HEADER_END__ ]]

--不屈の獣僕
function c8700633.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(8700633,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMINGS_CHECK_MONSTER+TIMING_MAIN_END)
	e1:SetRange(LOCATION_HAND+LOCATION_GRAVE)
	e1:SetCountLimit(1,8700633)
	e1:SetCondition(c8700633.spcon)
	e1:SetTarget(c8700633.sptg)
	e1:SetOperation(c8700633.spop)
	c:RegisterEffect(e1)
	if not c8700633.global_check then
		c8700633.global_check=true
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetCode(EVENT_SPSUMMON_SUCCESS)
		ge1:SetOperation(c8700633.checkop)
		Duel.RegisterEffect(ge1,0)
	end
	--ind
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e2:SetCondition(c8700633.indcon)
	e2:SetValue(1)
	c:RegisterEffect(e2)
end
function c8700633.checkop(e,tp,eg,ep,ev,re,r,rp)
	local tc=eg:GetFirst()
	while tc do
		Duel.RegisterFlagEffect(tc:GetSummonPlayer(),8700633,RESET_PHASE+PHASE_END,0,1)
		tc=eg:GetNext()
	end
end
function c8700633.spcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetFlagEffect(1-tp,8700633)>=3 and (Duel.GetCurrentPhase()==PHASE_MAIN1 or Duel.GetCurrentPhase()==PHASE_MAIN2)
end
function c8700633.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c8700633.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
end
function c8700633.indcon(e)
	return Duel.GetFieldGroupCount(e:GetHandlerPlayer(),LOCATION_MZONE,0)<=1 and e:GetHandler():IsPosition(POS_FACEUP_ATTACK)
end
