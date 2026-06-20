--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:37
-- Card: 冰晶  (ID: 98643358)
-- Type: Trap
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 场上的水属性怪兽全部破坏。那之后，给与对方基本分这个效果破坏送去墓地的水属性怪兽数量×500的数值的伤害。
--[[ __CARD_HEADER_END__ ]]

--ダイヤモンド・ダスト
function c98643358.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY+CATEGORY_DAMAGE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMINGS_CHECK_MONSTER+TIMING_END_PHASE)
	e1:SetTarget(c98643358.target)
	e1:SetOperation(c98643358.activate)
	c:RegisterEffect(e1)
end
function c98643358.filter(c)
	return c:IsFaceup() and c:IsAttribute(ATTRIBUTE_WATER)
end
function c98643358.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c98643358.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	local g=Duel.GetMatchingGroup(c98643358.filter,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,g:GetCount()*500)
end
function c98643358.ctfilter(c)
	return c:IsLocation(LOCATION_GRAVE) and c:IsAttribute(ATTRIBUTE_WATER)
end
function c98643358.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c98643358.filter,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	if Duel.Destroy(g,REASON_EFFECT)~=0 then
		local ct=Duel.GetOperatedGroup():FilterCount(c98643358.ctfilter,nil)
		if ct>0 then
			Duel.BreakEffect()
			Duel.Damage(1-tp,ct*500,REASON_EFFECT)
		end
	end
end
