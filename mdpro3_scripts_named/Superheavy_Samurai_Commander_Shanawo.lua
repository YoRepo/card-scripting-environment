--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: 超重神将 遮那王-O  (ID: 90587641)
-- Type: Monster / Effect / Synchro / Pendulum
-- Attribute: DARK
-- Race: Machine
-- Level 8
-- Pendulum Scales: L1 / R1
-- ATK 2000 | DEF 2500
-- Setcode: 154
--
-- Effect Text:
-- ←1 【灵摆】 1→
-- 这个卡名的灵摆效果1回合只能使用1次。
-- ①：对方怪兽的攻击宣言时才能发动。这张卡特殊召唤。自己墓地没有魔法·陷阱卡存在的场合，再让那只对方怪兽攻击力变成0，效果无效化。
-- 【怪兽效果】
-- 调整＋调整以外的怪兽1只以上
-- 这个卡名在规则上也当作「超重武者」卡使用。
-- ①：这张卡可以用表侧守备表示的状态作出攻击。那个场合，这张卡用守备力当作攻击力使用进行伤害计算。
-- ②：这张卡是已同调召唤的场合，1回合1次，自己·对方的战斗阶段才能发动。从自己墓地以及自己的魔法与陷阱区域的表侧表示的卡之中选1张「超重武者」怪兽卡特殊召唤。那之后，可以把这张卡在自己的灵摆区域放置。
--[[ __CARD_HEADER_END__ ]]

--超重神将シャナ－O
function c90587641.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure(c,nil,aux.NonTuner(nil),1)
	c:EnableReviveLimit()
	--pendulum summon
	aux.EnablePendulumAttribute(c,false)
	--spsummon (self)
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(90587641,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_ATKCHANGE+CATEGORY_DISABLE)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetRange(LOCATION_PZONE)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetCountLimit(1,90587641)
	e1:SetCondition(c90587641.spdcon)
	e1:SetTarget(c90587641.spdtg)
	e1:SetOperation(c90587641.spdop)
	c:RegisterEffect(e1)
	--defence attack
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_DEFENSE_ATTACK)
	e2:SetValue(1)
	c:RegisterEffect(e2)
	--spsummon
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(90587641,1))
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e3:SetType(EFFECT_TYPE_QUICK_O)
	e3:SetCode(EVENT_FREE_CHAIN)
	e3:SetRange(LOCATION_MZONE)
	e3:SetHintTiming(TIMING_BATTLE_START+TIMING_BATTLE_END)
	e3:SetCountLimit(1)
	e3:SetCondition(c90587641.spcon)
	e3:SetTarget(c90587641.sptg)
	e3:SetOperation(c90587641.spop)
	c:RegisterEffect(e3)
end
function c90587641.spdcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==1-tp
end
function c90587641.spdtg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	local tc=Duel.GetAttacker()
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and c:IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
	if not Duel.IsExistingMatchingCard(Card.IsType,tp,LOCATION_GRAVE,0,1,nil,TYPE_SPELL+TYPE_TRAP) then
		Duel.SetOperationInfo(0,CATEGORY_DISABLE,tc,1,0,0)
	end
end
function c90587641.spdop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetAttacker()
	if not c:IsRelateToEffect(e) or Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)==0 then return end
	if tc and tc:IsRelateToBattle()
		and not Duel.IsExistingMatchingCard(Card.IsType,tp,LOCATION_GRAVE,0,1,nil,TYPE_SPELL+TYPE_TRAP)
		and tc:IsControler(1-tp) and tc:IsFaceup()
		and (tc:GetAttack()>0 or aux.NegateMonsterFilter(tc)) then
		Duel.BreakEffect()
		Duel.NegateRelatedChain(tc,RESET_TURN_SET)
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetCode(EFFECT_DISABLE)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		tc:RegisterEffect(e1)
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e2:SetCode(EFFECT_DISABLE_EFFECT)
		e2:SetValue(RESET_TURN_SET)
		e2:SetReset(RESET_EVENT+RESETS_STANDARD)
		tc:RegisterEffect(e2)
		local e3=Effect.CreateEffect(c)
		e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e3:SetType(EFFECT_TYPE_SINGLE)
		e3:SetCode(EFFECT_SET_ATTACK_FINAL)
		e3:SetReset(RESET_EVENT+RESETS_STANDARD)
		e3:SetValue(0)
		tc:RegisterEffect(e3)
	end
end
function c90587641.spcon(e,tp,eg,ep,ev,re,r,rp)
	local ph=Duel.GetCurrentPhase()
	return e:GetHandler():IsSummonType(SUMMON_TYPE_SYNCHRO) and (ph>=PHASE_BATTLE_START and ph<=PHASE_BATTLE)
end
function c90587641.spfilter(c,e,tp)
	return c:IsSetCard(0x9a) and c:IsCanBeSpecialSummoned(e,0,tp,false,false) and c:IsFaceupEx()
end
function c90587641.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	local g=Duel.GetMatchingGroup(c90587641.spfilter,tp,LOCATION_SZONE+LOCATION_GRAVE,0,nil,e,tp)
	if chk==0 then return ft>0 and #g>0 end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_SZONE+LOCATION_GRAVE)
end
function c90587641.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	local g=Duel.GetMatchingGroup(aux.NecroValleyFilter(c90587641.spfilter),tp,LOCATION_SZONE+LOCATION_GRAVE,0,nil,e,tp)
	if ft<=0 or #g==0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local sg=g:Select(tp,1,1,nil)
	if Duel.SpecialSummon(sg,0,tp,tp,false,false,POS_FACEUP)>0
		and c:IsRelateToEffect(e) and (Duel.CheckLocation(tp,LOCATION_PZONE,0) or Duel.CheckLocation(tp,LOCATION_PZONE,1))
		and Duel.SelectYesNo(tp,aux.Stringid(90587641,2)) then
		Duel.BreakEffect()
		Duel.MoveToField(c,tp,tp,LOCATION_PZONE,POS_FACEUP,true)
	end
end
