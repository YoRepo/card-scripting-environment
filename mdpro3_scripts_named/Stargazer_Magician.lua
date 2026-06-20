--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:36
-- Card: 星读之魔术师  (ID: 94415058)
-- Type: Monster / Effect / Pendulum
-- Attribute: DARK
-- Race: Spellcaster
-- Level 5
-- Pendulum Scales: L1 / R1
-- ATK 1200 | DEF 2400
-- Setcode: 152
--
-- Effect Text:
-- ←1 【灵摆】 1→
-- ①：自己的灵摆怪兽进行战斗的场合，对方直到伤害步骤结束时魔法卡不能发动。
-- ②：另一边的自己的灵摆区域没有「魔术师」卡或者「异色眼」卡存在的场合，这张卡的灵摆刻度变成4。
-- 【怪兽效果】
-- ①：1回合1次，只让自己场上的灵摆怪兽1只因对方的效果回到自己手卡时才能发动。那1只同名怪兽从手卡特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--星読みの魔術師
function c94415058.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c)
	--actlimit
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetCode(EFFECT_CANNOT_ACTIVATE)
	e2:SetRange(LOCATION_PZONE)
	e2:SetTargetRange(0,1)
	e2:SetValue(c94415058.aclimit)
	e2:SetCondition(c94415058.actcon)
	c:RegisterEffect(e2)
	--scale
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetCode(EFFECT_CHANGE_LSCALE)
	e4:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e4:SetRange(LOCATION_PZONE)
	e4:SetCondition(c94415058.sccon)
	e4:SetValue(4)
	c:RegisterEffect(e4)
	local e5=e4:Clone()
	e5:SetCode(EFFECT_CHANGE_RSCALE)
	c:RegisterEffect(e5)
	--spsummon
	local e6=Effect.CreateEffect(c)
	e6:SetDescription(aux.Stringid(94415058,0))
	e6:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e6:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e6:SetCode(EVENT_TO_HAND)
	e6:SetRange(LOCATION_MZONE)
	e6:SetCountLimit(1)
	e6:SetCondition(c94415058.spcon)
	e6:SetTarget(c94415058.sptg)
	e6:SetOperation(c94415058.spop)
	c:RegisterEffect(e6)
end
function c94415058.actcon(e)
	local tp=e:GetHandlerPlayer()
	local tc=Duel.GetAttacker()
	if not tc then return false end
	if tc:IsControler(1-tp) then tc=Duel.GetAttackTarget() end
	return tc and tc:IsControler(tp) and tc:IsType(TYPE_PENDULUM)
end
function c94415058.aclimit(e,re,tp)
	return re:IsActiveType(TYPE_SPELL) and re:IsHasType(EFFECT_TYPE_ACTIVATE)
end
function c94415058.scfilter(c)
	return c:IsSetCard(0x98,0x99)
end
function c94415058.sccon(e)
	return not Duel.IsExistingMatchingCard(c94415058.scfilter,e:GetHandlerPlayer(),LOCATION_PZONE,0,1,e:GetHandler())
end
function c94415058.spcon(e,tp,eg,ep,ev,re,r,rp)
	local tc=eg:GetFirst()
	if eg:GetCount()==1 and rp==1-tp and tc:IsReason(REASON_EFFECT)
		and tc:IsPreviousControler(tp) and tc:IsPreviousLocation(LOCATION_MZONE) and tc:IsPreviousPosition(POS_FACEUP)
		and tc:IsType(TYPE_PENDULUM) and tc:IsControler(tp) then
		e:SetLabel(tc:GetCode())
		return true
	end
	return false
end
function c94415058.filter(c,e,tp,code)
	return c:IsCode(code) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c94415058.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c94415058.filter,tp,LOCATION_HAND,0,1,nil,e,tp,e:GetLabel()) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND)
end
function c94415058.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c94415058.filter,tp,LOCATION_HAND,0,1,1,nil,e,tp,e:GetLabel())
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
