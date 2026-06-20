--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 随风旅鸟与梦之町  (ID: 41215808)
-- Type: Trap
-- ATK 0 | DEF 0
-- Setcode: 365
--
-- Effect Text:
-- 这个卡名的②的效果1回合只能使用1次。
-- ①：自己·对方的主要阶段才能发动。把1只4星以下的鸟兽族怪兽召唤。
-- ②：这张卡在墓地存在的状态，自己对7星以上的怪兽的上级召唤成功的场合，把这张卡除外才能发动。对方场上的怪兽全部变成里侧守备表示。
--[[ __CARD_HEADER_END__ ]]

--ふわんだりぃずと夢の町
function c41215808.initial_effect(c)
	--Normal Summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(41215808,0))
	e1:SetCategory(CATEGORY_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMINGS_CHECK_MONSTER+TIMING_MAIN_END)
	e1:SetCondition(c41215808.sumcon)
	e1:SetTarget(c41215808.sumtg)
	e1:SetOperation(c41215808.sumop)
	c:RegisterEffect(e1)
	--Defense Position
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(41215808,1))
	e2:SetCategory(CATEGORY_POSITION+CATEGORY_MSET)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_SUMMON_SUCCESS)
	e2:SetProperty(EFFECT_FLAG_DELAY)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCountLimit(1,41215808)
	e2:SetCondition(c41215808.poscon)
	e2:SetCost(aux.bfgcost)
	e2:SetTarget(c41215808.postg)
	e2:SetOperation(c41215808.posop)
	c:RegisterEffect(e2)
end
function c41215808.sumcon(e,tp,eg,ep,ev,re,r,rp)
	local ph=Duel.GetCurrentPhase()
	return ph==PHASE_MAIN1 or ph==PHASE_MAIN2
end
function c41215808.sumfilter(c)
	return c:IsLevelBelow(4) and c:IsRace(RACE_WINDBEAST) and c:IsSummonable(true,nil)
end
function c41215808.sumtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c41215808.sumfilter,tp,LOCATION_HAND+LOCATION_MZONE,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_SUMMON,nil,1,0,0)
end
function c41215808.sumop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SUMMON)
	local g=Duel.SelectMatchingCard(tp,c41215808.sumfilter,tp,LOCATION_HAND+LOCATION_MZONE,0,1,1,nil)
	local tc=g:GetFirst()
	if tc then
		Duel.Summon(tp,tc,true,nil)
	end
end
function c41215808.cfilter(c,tp)
	return c:IsSummonPlayer(tp) and c:IsLevelAbove(7) and c:IsSummonType(SUMMON_TYPE_ADVANCE)
end
function c41215808.poscon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c41215808.cfilter,1,nil,tp)
end
function c41215808.posfilter(c)
	return c:IsFaceup() and c:IsCanTurnSet()
end
function c41215808.postg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c41215808.posfilter,tp,0,LOCATION_MZONE,1,nil) end
	local g=Duel.GetMatchingGroup(c41215808.posfilter,tp,0,LOCATION_MZONE,nil)
	Duel.SetOperationInfo(0,CATEGORY_POSITION,g,g:GetCount(),0,0)
end
function c41215808.posop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c41215808.posfilter,tp,0,LOCATION_MZONE,nil)
	if g:GetCount()>0 then
		Duel.ChangePosition(g,POS_FACEDOWN_DEFENSE)
	end
end
