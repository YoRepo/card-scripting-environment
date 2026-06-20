--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 骷髅外星人  (ID: 25920413)
-- Type: Monster / Effect
-- Attribute: WIND
-- Race: Reptile
-- Level 4
-- ATK 1600 | DEF 1800
-- Setcode: 12
--
-- Effect Text:
-- 可以把对方场上1只3星以下的怪兽解放，这张卡从手卡往对方场上特殊召唤。这个方法特殊召唤的场合，这个回合自己不能通常召唤，特殊召唤时给这张卡放置1个A指示物。只要这张卡在场上表侧表示存在，有A指示物放置
-- 的怪兽和名字带有「外星」的怪兽进行战斗的场合，只在伤害计算时A指示物每有1个攻击力·守备力下降300。
--[[ __CARD_HEADER_END__ ]]

--エーリアン・スカル
function c25920413.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_SPSUM_PARAM)
	e1:SetRange(LOCATION_HAND)
	e1:SetTargetRange(POS_FACEUP,1)
	e1:SetCondition(c25920413.spcon)
	e1:SetTarget(c25920413.sptg)
	e1:SetOperation(c25920413.spop)
	e1:SetValue(SUMMON_VALUE_SELF)
	c:RegisterEffect(e1)
	--counter
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(25920413,0))
	e2:SetCategory(CATEGORY_COUNTER)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetCondition(c25920413.ctcon)
	e2:SetOperation(c25920413.ctop)
	c:RegisterEffect(e2)
	--atk def
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_UPDATE_ATTACK)
	e3:SetRange(LOCATION_MZONE)
	e3:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e3:SetCondition(c25920413.adcon)
	e3:SetTarget(c25920413.adtg)
	e3:SetValue(c25920413.adval)
	c:RegisterEffect(e3)
	local e4=e3:Clone()
	e4:SetCode(EFFECT_UPDATE_DEFENSE)
	c:RegisterEffect(e4)
end
c25920413.counter_add_list={0x100e}
function c25920413.spfilter(c,tp)
	return c:IsLevelBelow(3) and c:IsFaceup() and c:IsReleasable(REASON_SPSUMMON)
		and Duel.GetMZoneCount(1-tp,c,tp)
end
function c25920413.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.GetActivityCount(tp,ACTIVITY_NORMALSUMMON)==0
		and Duel.IsExistingMatchingCard(c25920413.spfilter,tp,0,LOCATION_MZONE,1,nil,tp)
end
function c25920413.sptg(e,tp,eg,ep,ev,re,r,rp,chk,c)
	local g=Duel.GetMatchingGroup(c25920413.spfilter,tp,0,LOCATION_MZONE,nil,tp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RELEASE)
	local tc=g:SelectUnselect(nil,tp,false,true,1,1)
	if tc then
		e:SetLabelObject(tc)
		return true
	else return false end
end
function c25920413.spop(e,tp,eg,ep,ev,re,r,rp,c)
	local g=e:GetLabelObject()
	Duel.Release(g,REASON_SPSUMMON)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_SUMMON)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetReset(RESET_PHASE+PHASE_END)
	e1:SetTargetRange(1,0)
	Duel.RegisterEffect(e1,tp)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_CANNOT_MSET)
	Duel.RegisterEffect(e2,tp)
end
function c25920413.ctcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetSummonType()==SUMMON_TYPE_SPECIAL+SUMMON_VALUE_SELF
end
function c25920413.ctop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsFaceup() then
		c:AddCounter(0x100e,1)
	end
end
function c25920413.adcon(e)
	return Duel.GetCurrentPhase()==PHASE_DAMAGE_CAL and Duel.GetAttackTarget()
end
function c25920413.adtg(e,c)
	local bc=c:GetBattleTarget()
	return bc and c:GetCounter(0x100e)~=0 and bc:IsSetCard(0xc)
end
function c25920413.adval(e,c)
	return c:GetCounter(0x100e)*-300
end
