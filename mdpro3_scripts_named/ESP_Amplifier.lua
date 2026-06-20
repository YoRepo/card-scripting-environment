--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: 超能力增幅器  (ID: 84653834)
-- Type: Spell / Continuous
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 这张卡的发动时，自己场上表侧表示存在的全部念动力族怪兽的攻击力上升从游戏中除外的自己的念动力族怪兽数量×300的数值。受到这个效果影响的怪兽在结束阶段时从游戏中除外。
--[[ __CARD_HEADER_END__ ]]

--超能力増幅器
function c84653834.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(TIMING_DAMAGE_STEP)
	e1:SetCondition(c84653834.condition)
	e1:SetTarget(c84653834.target)
	e1:SetOperation(c84653834.activate)
	c:RegisterEffect(e1)
end
function c84653834.condition(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetCurrentPhase()==PHASE_DAMAGE and Duel.IsDamageCalculated() then return false end
	return true
end
function c84653834.filter(c)
	return c:IsFaceup() and c:IsRace(RACE_PSYCHO)
end
function c84653834.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c84653834.filter,tp,LOCATION_MZONE,0,1,nil) end
end
function c84653834.activate(e,tp,eg,ep,ev,re,r,rp)
	local sg=Duel.GetMatchingGroup(c84653834.filter,tp,LOCATION_MZONE,0,nil)
	local c=e:GetHandler()
	local tc=sg:GetFirst()
	local atk=Duel.GetMatchingGroupCount(c84653834.filter,tp,LOCATION_REMOVED,0,nil)*300
	while tc do
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		e1:SetValue(atk)
		tc:RegisterEffect(e1)
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e2:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
		e2:SetCode(EVENT_PHASE+PHASE_END)
		e2:SetRange(LOCATION_MZONE)
		e2:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		e2:SetCountLimit(1)
		e2:SetOperation(c84653834.rmop)
		tc:RegisterEffect(e2)
		tc=sg:GetNext()
	end
end
function c84653834.rmop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Remove(e:GetHandler(),POS_FACEUP,REASON_EFFECT)
end
