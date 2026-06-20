--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 冥骸府-莫忘冥府  (ID: 43338320)
-- Type: Spell / Counter
-- ATK 0 | DEF 0
-- Setcode: 417
--
-- Effect Text:
-- 这个卡名的②的效果1回合只能使用1次。
-- ①：自己的「莫忘」怪兽进行战斗的场合，对方直到伤害步骤结束时魔法·陷阱卡不能发动。
-- ②：自己场上的怪兽被战斗·效果破坏的场合，以那之内的1只为对象才能发动。比那只怪兽等级低的1只「莫忘」怪兽从自己的手卡·墓地特殊召唤。
-- ③：自己结束阶段，以自己墓地1张「莫忘」魔法·陷阱卡为对象才能发动。那张卡在自己场上盖放。
--[[ __CARD_HEADER_END__ ]]

--冥骸府－メメントラン
local s,id,o=GetID()
function s.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--limit effect
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_CANNOT_ACTIVATE)
	e2:SetRange(LOCATION_FZONE)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetTargetRange(0,1)
	e2:SetCondition(s.lecon)
	e2:SetValue(aux.TargetBoolFunction(Effect.IsHasType,EFFECT_TYPE_ACTIVATE))
	c:RegisterEffect(e2)
	--spsummon
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(id,0))
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_DESTROYED)
	e3:SetRange(LOCATION_FZONE)
	e3:SetCountLimit(1,id)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e3:SetTarget(s.sptg)
	e3:SetOperation(s.spop)
	c:RegisterEffect(e3)
	--set
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(id,1))
	e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e4:SetCode(EVENT_PHASE+PHASE_END)
	e4:SetRange(LOCATION_FZONE)
	e4:SetCountLimit(1)
	e4:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e4:SetCategory(CATEGORY_SSET)
	e4:SetCondition(s.setcon)
	e4:SetTarget(s.settg)
	e4:SetOperation(s.setop)
	c:RegisterEffect(e4)
end
function s.lfilter(c,tp)
	return c:IsControler(tp) and c:IsFaceup() and c:IsSetCard(0x1a1)
end
function s.lecon(e)
	local a=Duel.GetAttacker()
	local d=Duel.GetAttackTarget()
	local tp=e:GetHandlerPlayer()
	return a and s.lfilter(a,tp) or d and s.lfilter(d,tp)
end
function s.cfilter(c,e,tp)
	return c:IsPreviousControler(tp) and c:IsPreviousLocation(LOCATION_MZONE) and not c:IsType(TYPE_TOKEN)
		and c:IsReason(REASON_BATTLE+REASON_EFFECT) and c:IsCanBeEffectTarget(e) and c:IsFaceupEx()
		and c:IsLevelAbove(2) and Duel.IsExistingMatchingCard(s.filter,tp,LOCATION_GRAVE+LOCATION_HAND,0,1,nil,e,tp,c:GetLevel())
end
function s.filter(c,e,tp,lv)
	return c:IsSetCard(0x1a1) and c:IsLevelBelow(lv-1) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function s.sptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return eg:IsContains(chkc) and chkc:IsPreviousControler(tp)
		and chkc:IsPreviousLocation(LOCATION_MZONE) and chkc:IsReason(REASON_BATTLE+REASON_EFFECT) end
	local g=eg:Filter(s.cfilter,nil,e,tp)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and #g>0 end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	local sg=g:Select(tp,1,1,nil)
	Duel.SetTargetCard(sg)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_GRAVE+LOCATION_HAND)
end
function s.spop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if not tc:IsRelateToEffect(e) or Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,aux.NecroValleyFilter(s.filter),tp,LOCATION_GRAVE+LOCATION_HAND,0,1,1,nil,e,tp,tc:GetLevel())
	Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
end
function s.setcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp
end
function s.sfilter(c)
	return c:IsSetCard(0x1a1) and c:IsType(TYPE_SPELL+TYPE_TRAP) and c:IsSSetable()
end
function s.settg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and s.sfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(s.sfilter,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SET)
	local g=Duel.SelectTarget(tp,s.sfilter,tp,LOCATION_GRAVE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_LEAVE_GRAVE,g,1,0,0)
end
function s.setop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then Duel.SSet(tp,tc) end
end
