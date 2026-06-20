--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 幻兽机 绳狼  (ID: 67922702)
-- Type: Monster / Effect
-- Attribute: WIND
-- Race: Machine
-- Level 4
-- ATK 1700 | DEF 1200
-- Setcode: 4123
--
-- Effect Text:
-- ①：这张卡召唤成功的场合发动。在自己场上把1只「幻兽机衍生物」（机械族·风·3星·攻/守0）特殊召唤。
-- ②：这张卡的等级上升自己场上的「幻兽机衍生物」的等级的合计数值。
-- ③：只要自己场上有衍生物存在，这张卡不会被战斗·效果破坏。
-- ④：这张卡和对方怪兽进行战斗的从伤害步骤开始时到伤害计算前1次，把自己场上1只衍生物解放才能发动。这张卡的攻击力直到回合结束时上升800。
--[[ __CARD_HEADER_END__ ]]

--幻獣機テザーウルフ
function c67922702.initial_effect(c)
	--level
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_UPDATE_LEVEL)
	e1:SetValue(c67922702.lvval)
	c:RegisterEffect(e1)
	--
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e2:SetCondition(aux.tkfcon)
	e2:SetValue(1)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	c:RegisterEffect(e3)
	--token
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(67922702,0))
	e4:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOKEN)
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e4:SetCode(EVENT_SUMMON_SUCCESS)
	e4:SetTarget(c67922702.sptg)
	e4:SetOperation(c67922702.spop)
	c:RegisterEffect(e4)
	--atkup
	local e5=Effect.CreateEffect(c)
	e5:SetDescription(aux.Stringid(67922702,1))
	e5:SetCategory(CATEGORY_ATKCHANGE)
	e5:SetType(EFFECT_TYPE_QUICK_O)
	e5:SetRange(LOCATION_MZONE)
	e5:SetCode(EVENT_FREE_CHAIN)
	e5:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e5:SetHintTiming(TIMING_DAMAGE_STEP)
	e5:SetCondition(c67922702.atkcon)
	e5:SetCost(c67922702.atkcost)
	e5:SetOperation(c67922702.atkop)
	c:RegisterEffect(e5)
end
function c67922702.lvval(e,c)
	local tp=c:GetControler()
	return Duel.GetMatchingGroup(Card.IsCode,tp,LOCATION_MZONE,0,nil,31533705):GetSum(Card.GetLevel)
end
function c67922702.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,0)
end
function c67922702.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	if Duel.IsPlayerCanSpecialSummonMonster(tp,31533705,0x101b,TYPES_TOKEN_MONSTER,0,0,3,RACE_MACHINE,ATTRIBUTE_WIND) then
		local token=Duel.CreateToken(tp,67922703)
		Duel.SpecialSummon(token,0,tp,tp,false,false,POS_FACEUP)
	end
end
function c67922702.atkcon(e,tp,eg,ep,ev,re,r,rp)
	local phase=Duel.GetCurrentPhase()
	return e:GetHandler():GetBattleTarget()~=nil and phase==PHASE_DAMAGE and not Duel.IsDamageCalculated()
end
function c67922702.atkcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():GetFlagEffect(67922702)==0
		and Duel.CheckReleaseGroup(tp,Card.IsType,1,nil,TYPE_TOKEN) end
	local g=Duel.SelectReleaseGroup(tp,Card.IsType,1,1,nil,TYPE_TOKEN)
	Duel.Release(g,REASON_COST)
	e:GetHandler():RegisterFlagEffect(67922702,RESET_PHASE+PHASE_DAMAGE_CAL,0,1)
end
function c67922702.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetValue(800)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
	c:RegisterEffect(e1)
end
