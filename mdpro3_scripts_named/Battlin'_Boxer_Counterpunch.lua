--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: 燃烧拳击手 反击拳手  (ID: 4549095)
-- Type: Monster / Effect
-- Attribute: FIRE
-- Race: Warrior
-- Level 3
-- ATK 0 | DEF 1100
-- Setcode: 4228
--
-- Effect Text:
-- 自己场上的名字带有「燃烧拳击手」的怪兽进行战斗的伤害步骤时把手卡或者墓地的这张卡从游戏中除外才能发动。那只怪兽的攻击力直到结束阶段时上升1000。「燃烧拳击手 反击拳手」的效果1回合只能使用1次。
--[[ __CARD_HEADER_END__ ]]

--BK カウンターブロー
function c4549095.initial_effect(c)
	--atkup
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetDescription(aux.Stringid(4549095,0))
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(TIMING_DAMAGE_STEP)
	e1:SetRange(LOCATION_HAND+LOCATION_GRAVE)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e1:SetCountLimit(1,4549095)
	e1:SetCondition(c4549095.condition)
	e1:SetCost(c4549095.cost)
	e1:SetOperation(c4549095.operation)
	c:RegisterEffect(e1)
end
function c4549095.condition(e,tp,eg,ep,ev,re,r,rp)
	local phase=Duel.GetCurrentPhase()
	if phase~=PHASE_DAMAGE or Duel.IsDamageCalculated() then return false end
	local a=Duel.GetAttacker()
	local d=Duel.GetAttackTarget()
	return (a:IsControler(tp) and a:IsSetCard(0x1084) and a:IsRelateToBattle())
		or (d and d:IsControler(tp) and d:IsSetCard(0x1084) and d:IsRelateToBattle())
end
function c4549095.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToRemoveAsCost() end
	Duel.Remove(e:GetHandler(),POS_FACEUP,REASON_COST)
end
function c4549095.operation(e,tp,eg,ep,ev,re,r,rp)
	local a=Duel.GetAttacker()
	if Duel.GetTurnPlayer()~=tp then a=Duel.GetAttackTarget() end
	if not a:IsRelateToBattle() then return end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
	e1:SetValue(1000)
	a:RegisterEffect(e1)
end
