--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 狂焰  (ID: 68815401)
-- Type: Spell / Continuous
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 支付500基本分。自己场上表侧表示存在的名字带有「烈焰加农炮」的卡破坏，场上的怪兽全部破坏。之后，在自己场上攻击表示特殊召唤1只「狂焰衍生物」（炎族·炎·3星·攻/守1000）。这个回合自己怪兽不能攻
-- 击。
--[[ __CARD_HEADER_END__ ]]

--クレイジー・ファイヤー
function c68815401.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY+CATEGORY_SPECIAL_SUMMON+CATEGORY_TOKEN)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMINGS_CHECK_MONSTER)
	e1:SetCost(c68815401.cost)
	e1:SetTarget(c68815401.target)
	e1:SetOperation(c68815401.activate)
	c:RegisterEffect(e1)
end
function c68815401.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(tp,500) and Duel.GetActivityCount(tp,ACTIVITY_ATTACK)==0 end
	Duel.PayLPCost(tp,500)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_ATTACK)
	e1:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE+EFFECT_FLAG_OATH)
	e1:SetTargetRange(LOCATION_MZONE,0)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
function c68815401.filter1(c)
	return c:IsFaceup() and c:IsSetCard(0xb9)
end
function c68815401.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c68815401.filter1,tp,LOCATION_SZONE,0,1,nil)
		and Duel.IsExistingMatchingCard(aux.TRUE,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil)
		and Duel.IsPlayerCanSpecialSummonMonster(tp,68815402,0,TYPES_TOKEN_MONSTER,1000,1000,3,RACE_PYRO,ATTRIBUTE_FIRE,POS_FACEUP_ATTACK) end
	local dg1=Duel.GetMatchingGroup(c68815401.filter1,tp,LOCATION_SZONE,0,nil)
	local dg2=Duel.GetMatchingGroup(aux.TRUE,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	dg1:Merge(dg2)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,dg1,dg1:GetCount(),0,0)
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,0)
end
function c68815401.activate(e,tp,eg,ep,ev,re,r,rp)
	local dg1=Duel.GetMatchingGroup(c68815401.filter1,tp,LOCATION_SZONE,0,nil)
	if Duel.Destroy(dg1,REASON_EFFECT)>0 then
		local dg2=Duel.GetMatchingGroup(aux.TRUE,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
		if Duel.Destroy(dg2,REASON_EFFECT)>0
			and Duel.IsPlayerCanSpecialSummonMonster(tp,68815402,0,TYPES_TOKEN_MONSTER,1000,1000,3,RACE_PYRO,ATTRIBUTE_FIRE,POS_FACEUP_ATTACK) then
			Duel.BreakEffect()
			local token=Duel.CreateToken(tp,68815402)
			Duel.SpecialSummon(token,0,tp,tp,false,false,POS_FACEUP_ATTACK)
		end
	end
end
