--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 群豪之聚-幻中  (ID: 40680521)
-- Type: Monster / Effect / Fusion / Pendulum
-- Attribute: WATER
-- Race: Spellcaster
-- Level 10
-- Pendulum Scales: L10 / R10
-- ATK 2800 | DEF 2800
-- Setcode: 381
--
-- Effect Text:
-- ←10 【灵摆】 10→
-- 这个卡名的灵摆效果1回合只能使用1次。
-- ①：可以从以下效果选择1个发动。
-- ●这张卡在正对面的自己的主要怪兽区域特殊召唤。
-- ●选自己的主要怪兽区域1只怪兽，那个位置向那个相邻的怪兽区域移动。
-- 【怪兽效果】
-- 「群豪」怪兽×3
-- 这个卡名的①的怪兽效果1回合只能使用1次。
-- ①：双方的主要阶段，以对方的主要怪兽区域1只效果怪兽为对象才能发动。那只对方怪兽在和那只是相同纵列的对方的魔法与陷阱区域当作永续魔法卡使用以表侧表示放置（所要放置区的卡破坏，那是怪兽卡的场合，对方失去
-- 那个攻击力数值的基本分）。
-- ②：特殊召唤的这张卡被对方的效果破坏的场合才能发动。这张卡在自己的灵摆区域放置。
--[[ __CARD_HEADER_END__ ]]

--ヴァリアンツの聚－幻中
function c40680521.initial_effect(c)
	--fusion summon
	c:EnableReviveLimit()
	aux.AddFusionProcFunRep(c,c40680521.ffilter,3,true)
	--pendulum summon
	aux.EnablePendulumAttribute(c,false)
	--pzone effect
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_PZONE)
	e1:SetCountLimit(1,40680521)
	e1:SetTarget(c40680521.ptg)
	e1:SetOperation(c40680521.pop)
	c:RegisterEffect(e1)
	--set
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetRange(LOCATION_MZONE)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetCountLimit(1,40680522)
	e2:SetHintTiming(0,TIMINGS_CHECK_MONSTER+TIMING_MAIN_END)
	e2:SetCondition(c40680521.stcon)
	e2:SetTarget(c40680521.sttg)
	e2:SetOperation(c40680521.stop)
	c:RegisterEffect(e2)
	--pendulum
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_DESTROYED)
	e3:SetProperty(EFFECT_FLAG_DELAY)
	e3:SetCondition(c40680521.pencon)
	e3:SetTarget(c40680521.pentg)
	e3:SetOperation(c40680521.penop)
	c:RegisterEffect(e3)
end
function c40680521.ffilter(c,fc,sub,mg,sg)
	return c:IsFusionSetCard(0x17d)
end
function c40680521.pfilter(c)
	local seq=c:GetSequence()
	local tp=c:GetControler()
	if seq>4 then return false end
	return (seq>0 and Duel.CheckLocation(tp,LOCATION_MZONE,seq-1))
		or (seq<4 and Duel.CheckLocation(tp,LOCATION_MZONE,seq+1))
end
function c40680521.ptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	local zone=1<<c:GetSequence()
	local b1=c:IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEUP,tp,zone)
	local b2=Duel.IsExistingMatchingCard(c40680521.pfilter,tp,LOCATION_MZONE,0,1,nil)
	if chk==0 then return b1 or b2 end
	local s=0
	if b1 and not b2 then
		s=Duel.SelectOption(tp,aux.Stringid(40680521,0))
	end
	if not b1 and b2 then
		s=Duel.SelectOption(tp,aux.Stringid(40680521,1))+1
	end
	if b1 and b2 then
		s=Duel.SelectOption(tp,aux.Stringid(40680521,0),aux.Stringid(40680521,1))
	end
	e:SetLabel(s)
	if s==0 then
		Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,c,1,0,0)
	end
end
function c40680521.pop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	local zone=1<<c:GetSequence()
	if e:GetLabel()==0 then
		Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP,zone)
	end
	if e:GetLabel()==1 then
		Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(40680521,2))
		local sc=Duel.SelectMatchingCard(tp,c40680521.pfilter,tp,LOCATION_MZONE,0,1,1,nil):GetFirst()
		if sc then
			local seq=sc:GetSequence()
			if seq>4 then return end
			local flag=0
			if seq>0 and Duel.CheckLocation(tp,LOCATION_MZONE,seq-1) then flag=flag|(1<<(seq-1)) end
			if seq<4 and Duel.CheckLocation(tp,LOCATION_MZONE,seq+1) then flag=flag|(1<<(seq+1)) end
			if flag==0 then return end
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOZONE)
			local s=Duel.SelectDisableField(tp,1,LOCATION_MZONE,0,~flag)
			local nseq=math.log(s,2)
			Duel.MoveSequence(sc,nseq)
		end
	end
end
function c40680521.stcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetCurrentPhase()==PHASE_MAIN1 or Duel.GetCurrentPhase()==PHASE_MAIN2
end
function c40680521.stfilter(c)
	local seq=c:GetSequence()
	return seq<=4 and c:IsType(TYPE_EFFECT) and c:IsFaceup()
end
function c40680521.sttg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) and c40680521.stfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c40680521.stfilter,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(40680521,3))
	Duel.SelectTarget(tp,c40680521.stfilter,tp,0,LOCATION_MZONE,1,1,nil)
end
function c40680521.stop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if not (tc:IsRelateToEffect(e) and tc:IsControler(1-tp) and not tc:IsImmuneToEffect(e)) then return end
	local zone=1<<tc:GetSequence()
	local oc=Duel.GetMatchingGroup(c40680521.seqfilter,tp,0,LOCATION_SZONE,nil,tc:GetSequence()):GetFirst()
	if oc and Duel.Destroy(oc,REASON_RULE)>0 and oc:IsType(TYPE_MONSTER) then
		Duel.SetLP(1-tp,Duel.GetLP(1-tp)-oc:GetAttack())
	end
	if Duel.MoveToField(tc,tp,1-tp,LOCATION_SZONE,POS_FACEUP,true,zone) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetCode(EFFECT_CHANGE_TYPE)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD-RESET_TURN_SET)
		e1:SetValue(TYPE_SPELL+TYPE_CONTINUOUS)
		tc:RegisterEffect(e1)
	end
end
function c40680521.seqfilter(c,seq)
	return c:GetSequence()==seq
end
function c40680521.pencon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsSummonType(SUMMON_TYPE_SPECIAL) and rp==1-tp and c:IsReason(REASON_EFFECT)
		and c:IsPreviousControler(tp) and c:IsPreviousLocation(LOCATION_MZONE) and c:IsFaceup()
end
function c40680521.pentg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLocation(tp,LOCATION_PZONE,0) or Duel.CheckLocation(tp,LOCATION_PZONE,1) end
end
function c40680521.penop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		Duel.MoveToField(c,tp,tp,LOCATION_PZONE,POS_FACEUP,true)
	end
end
