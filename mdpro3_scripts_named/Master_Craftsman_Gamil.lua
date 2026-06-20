--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 名匠 加米尔  (ID: 25727454)
-- Type: Monster / Effect
-- Attribute: FIRE
-- Race: Pyro
-- Level 2
-- ATK 200 | DEF 200
--
-- Effect Text:
-- ①：自己怪兽进行战斗的从伤害步骤开始时到伤害计算前，把这张卡从手卡送去墓地才能发动。那只怪兽的攻击力直到回合结束时上升300。
--[[ __CARD_HEADER_END__ ]]

--名匠 ガミル
function c25727454.initial_effect(c)
	--atkup
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(25727454,0))
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(TIMING_DAMAGE_STEP)
	e1:SetRange(LOCATION_HAND)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e1:SetCondition(c25727454.condition)
	e1:SetCost(c25727454.cost)
	e1:SetOperation(c25727454.operation)
	c:RegisterEffect(e1)
end
function c25727454.condition(e,tp,eg,ep,ev,re,r,rp)
	local phase=Duel.GetCurrentPhase()
	if phase~=PHASE_DAMAGE or Duel.IsDamageCalculated() then return false end
	local a=Duel.GetAttacker()
	local d=Duel.GetAttackTarget()
	return (a:IsControler(tp) and a:IsRelateToBattle()) or (d and d:IsControler(tp) and d:IsRelateToBattle())
end
function c25727454.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToGraveAsCost() end
	Duel.SendtoGrave(e:GetHandler(),REASON_COST)
end
function c25727454.operation(e,tp,eg,ep,ev,re,r,rp)
	local a=Duel.GetAttacker()
	if Duel.GetTurnPlayer()~=tp then a=Duel.GetAttackTarget() end
	if not a:IsRelateToBattle() or a:IsFacedown() then return end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
	e1:SetValue(300)
	a:RegisterEffect(e1)
end
