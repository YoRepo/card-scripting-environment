--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 爆裂斩  (ID: 40012727)
-- Type: Trap
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 自己场上有名字带有「/爆裂体」的怪兽表侧表示存在的场合才能发动。场上表侧表示存在的怪兽全部破坏。
--[[ __CARD_HEADER_END__ ]]

--バスター・スラッシュ
function c40012727.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMINGS_CHECK_MONSTER+TIMING_END_PHASE)
	e1:SetCondition(c40012727.condition)
	e1:SetTarget(c40012727.target)
	e1:SetOperation(c40012727.activate)
	c:RegisterEffect(e1)
end
function c40012727.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x104f)
end
function c40012727.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c40012727.cfilter,tp,LOCATION_MZONE,0,1,nil)
end
function c40012727.filter(c)
	return c:IsFaceup()
end
function c40012727.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c40012727.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	local dg=Duel.GetMatchingGroup(c40012727.filter,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,dg,dg:GetCount(),0,0)
end
function c40012727.activate(e,tp,eg,ep,ev,re,r,rp)
	local dg=Duel.GetMatchingGroup(c40012727.filter,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	Duel.Destroy(dg,REASON_EFFECT)
end
