--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 侏罗纪冲击  (ID: 65430834)
-- Type: Trap
-- ATK 0 | DEF 0
--
-- Effect Text:
-- ①：自己场上有恐龙族怪兽2只以上存在，自己基本分比对方少的场合才能发动。场上的怪兽全部破坏，自己受到破坏的怪兽数量×1000伤害。那之后，给与对方为和自己受到的伤害相同数值的伤害。这张卡的发动后，直到
-- 下个回合的结束时双方不能把怪兽召唤·特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--ジュラシック・インパクト
function c65430834.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY+CATEGORY_DAMAGE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMINGS_CHECK_MONSTER+TIMING_END_PHASE)
	e1:SetCondition(c65430834.condition)
	e1:SetTarget(c65430834.target)
	e1:SetOperation(c65430834.activate)
	c:RegisterEffect(e1)
end
function c65430834.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(Card.IsRace,tp,LOCATION_MZONE,0,2,nil,RACE_DINOSAUR) and Duel.GetLP(tp)<Duel.GetLP(1-tp)
end
function c65430834.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFieldGroupCount(tp,LOCATION_MZONE,LOCATION_MZONE)>0 end
	local g=Duel.GetFieldGroup(tp,LOCATION_MZONE,LOCATION_MZONE)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,PLAYER_ALL,g:GetCount()*1000)
end
function c65430834.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetFieldGroup(tp,LOCATION_MZONE,LOCATION_MZONE)
	local ct=Duel.Destroy(g,REASON_EFFECT)
	if ct>0 then
		local val=Duel.Damage(tp,ct*1000,REASON_EFFECT)
		if val>0 and Duel.GetLP(tp)>0 then
			Duel.BreakEffect()
			Duel.Damage(1-tp,val,REASON_EFFECT)
		end
	end
	if e:IsHasType(EFFECT_TYPE_ACTIVATE) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_FIELD)
		e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
		e1:SetCode(EFFECT_CANNOT_SUMMON)
		e1:SetTargetRange(1,1)
		e1:SetReset(RESET_PHASE+PHASE_END,2)
		Duel.RegisterEffect(e1,tp)
		local e2=e1:Clone()
		e2:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
		Duel.RegisterEffect(e2,tp)
	end
end
