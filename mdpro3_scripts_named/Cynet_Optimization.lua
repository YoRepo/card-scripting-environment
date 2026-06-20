--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:26
-- Card: 电脑网优化  (ID: 34010534)
-- Type: Spell / Equip
-- ATK 0 | DEF 0
-- Setcode: 280
--
-- Effect Text:
-- 这个卡名的①的效果1回合只能使用1次。
-- ①：自己主要阶段才能发动。把1只电子界族怪兽召唤。这个效果的发动后，直到回合结束时自己不是电子界族怪兽不能从额外卡组特殊召唤。
-- ②：自己的「码语者」怪兽进行战斗的场合，对方直到伤害步骤结束时魔法·陷阱·怪兽的效果不能发动。
--[[ __CARD_HEADER_END__ ]]

--サイバネット・オプティマイズ
function c34010534.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--summon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(34010534,0))
	e2:SetCategory(CATEGORY_SUMMON)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCountLimit(1,34010534)
	e2:SetTarget(c34010534.sumtg)
	e2:SetOperation(c34010534.sumop)
	c:RegisterEffect(e2)
	--actlimit
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e3:SetCode(EFFECT_CANNOT_ACTIVATE)
	e3:SetRange(LOCATION_SZONE)
	e3:SetTargetRange(0,1)
	e3:SetCondition(c34010534.actcon)
	e3:SetValue(1)
	c:RegisterEffect(e3)
end
function c34010534.sumfilter(c)
	return c:IsRace(RACE_CYBERSE) and c:IsSummonable(true,nil)
end
function c34010534.sumtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c34010534.sumfilter,tp,LOCATION_HAND+LOCATION_MZONE,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_SUMMON,nil,1,0,0)
end
function c34010534.sumop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SUMMON)
	local g=Duel.SelectMatchingCard(tp,c34010534.sumfilter,tp,LOCATION_HAND+LOCATION_MZONE,0,1,1,nil)
	local tc=g:GetFirst()
	if tc then
		Duel.Summon(tp,tc,true,nil)
	end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTargetRange(1,0)
	e1:SetTarget(c34010534.splimit)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
function c34010534.splimit(e,c)
	return not c:IsRace(RACE_CYBERSE) and c:IsLocation(LOCATION_EXTRA)
end
function c34010534.cfilter(c,tp)
	return c:IsFaceup() and c:IsSetCard(0x101) and c:IsControler(tp)
end
function c34010534.actcon(e)
	local tp=e:GetHandlerPlayer()
	local a=Duel.GetAttacker()
	local d=Duel.GetAttackTarget()
	return (a and c34010534.cfilter(a,tp)) or (d and c34010534.cfilter(d,tp))
end
