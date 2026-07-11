--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:42
-- Source DB: cards.cdb
-- Card: Proof of Powerlessness  (ID: 11373345)
-- Type: Trap
-- Scope: OCG / TCG
--
-- Effect Text:
-- Activate only while you control a face-up Level 7 or higher monster.
-- Destroy all face-up Level 5 or lower monsters your opponent controls.
-- Monsters you control cannot attack this turn.
--[[ __CARD_HEADER_END__ ]]

--無力の証明
function c11373345.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMINGS_CHECK_MONSTER)
	e1:SetCondition(c11373345.condition)
	e1:SetCost(c11373345.cost)
	e1:SetTarget(c11373345.target)
	e1:SetOperation(c11373345.activate)
	c:RegisterEffect(e1)
end
function c11373345.cfilter(c)
	return c:IsFaceup() and c:IsLevelAbove(7)
end
function c11373345.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c11373345.cfilter,tp,LOCATION_MZONE,0,1,nil)
end
function c11373345.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetActivityCount(tp,ACTIVITY_ATTACK)==0 end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_ATTACK)
	e1:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE+EFFECT_FLAG_OATH)
	e1:SetTargetRange(LOCATION_MZONE,0)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
function c11373345.filter(c)
	return c:IsFaceup() and c:IsLevelBelow(5)
end
function c11373345.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c11373345.filter,tp,0,LOCATION_MZONE,1,nil) end
	local sg=Duel.GetMatchingGroup(c11373345.filter,tp,0,LOCATION_MZONE,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,sg,sg:GetCount(),0,0)
end
function c11373345.activate(e,tp,eg,ep,ev,re,r,rp)
	local sg=Duel.GetMatchingGroup(c11373345.filter,tp,0,LOCATION_MZONE,nil)
	Duel.Destroy(sg,REASON_EFFECT)
end
