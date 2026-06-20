--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:37
-- Card: 冰骑士  (ID: 99328137)
-- Type: Monster / Effect
-- Attribute: WATER
-- Race: Aqua
-- Level 4
-- ATK 1300 | DEF 1200
--
-- Effect Text:
-- ①：这张卡的攻击力上升自己场上的水族怪兽数量×400。
-- ②：1回合1次，自己主要阶段才能发动。这个回合，自己在通常召唤外加上只有1次，自己主要阶段可以把1只水属性怪兽召唤。这个效果的发动后，直到回合结束时自己不是水属性怪兽不能召唤·特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--氷騎士
function c99328137.initial_effect(c)
	--atkup
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetRange(LOCATION_MZONE)
	e1:SetValue(c99328137.val)
	c:RegisterEffect(e1)
	--extra normal summon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(99328137,0))
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetTarget(c99328137.sumtg)
	e2:SetOperation(c99328137.sumop)
	c:RegisterEffect(e2)
end
function c99328137.cfilter(c)
	return c:IsFaceup() and c:IsRace(RACE_AQUA)
end
function c99328137.val(e,c)
	return Duel.GetMatchingGroupCount(c99328137.cfilter,c:GetControler(),LOCATION_MZONE,0,nil)*400
end
function c99328137.sumtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanSummon(tp) and Duel.IsPlayerCanAdditionalSummon(tp)
		and Duel.GetFlagEffect(tp,99328137)==0 end
end
function c99328137.sumop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetFlagEffect(tp,94076521)==0 then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetDescription(aux.Stringid(99328137,1))
		e1:SetType(EFFECT_TYPE_FIELD)
		e1:SetTargetRange(LOCATION_HAND+LOCATION_MZONE,0)
		e1:SetCode(EFFECT_EXTRA_SUMMON_COUNT)
		e1:SetTarget(c99328137.extrasumtg)
		e1:SetReset(RESET_PHASE+PHASE_END)
		Duel.RegisterEffect(e1,tp)
		Duel.RegisterFlagEffect(tp,99328137,RESET_PHASE+PHASE_END,0,1)
	end
	local e2=Effect.CreateEffect(e:GetHandler())
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_CANNOT_SUMMON)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetTargetRange(1,0)
	e2:SetTarget(c99328137.splimit)
	e2:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e2,tp)
	local e3=e2:Clone()
	e3:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	Duel.RegisterEffect(e3,tp)
end
function c99328137.extrasumtg(e,c)
	return c:IsAttribute(ATTRIBUTE_WATER)
end
function c99328137.splimit(e,c)
	return not c:IsAttribute(ATTRIBUTE_WATER)
end
