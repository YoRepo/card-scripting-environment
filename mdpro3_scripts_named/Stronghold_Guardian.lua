--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:24
-- Card: 牙城守护者  (ID: 23535429)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Warrior
-- Level 4
-- ATK 0 | DEF 1500
-- Setcode: 82
--
-- Effect Text:
-- 自己场上守备表示存在的怪兽被攻击的场合，那次伤害步骤时可以把这张卡从手卡送去墓地，进行那次战斗的自己怪兽的守备力直到结束阶段时上升1500。
--[[ __CARD_HEADER_END__ ]]

--牙城のガーディアン
function c23535429.initial_effect(c)
	--defup
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(23535429,0))
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(TIMING_DAMAGE_STEP)
	e1:SetRange(LOCATION_HAND)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e1:SetCondition(c23535429.condition)
	e1:SetCost(c23535429.cost)
	e1:SetOperation(c23535429.operation)
	c:RegisterEffect(e1)
end
function c23535429.condition(e,tp,eg,ep,ev,re,r,rp)
	local phase=Duel.GetCurrentPhase()
	if phase~=PHASE_DAMAGE or Duel.IsDamageCalculated() then return false end
	local d=Duel.GetAttackTarget()
	return d and d:IsControler(tp) and d:IsDefensePos()
end
function c23535429.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToGraveAsCost() end
	Duel.SendtoGrave(e:GetHandler(),REASON_COST)
end
function c23535429.operation(e,tp,eg,ep,ev,re,r,rp)
	local d=Duel.GetAttackTarget()
	if not d:IsRelateToBattle() then return end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_DEFENSE)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
	e1:SetValue(1500)
	d:RegisterEffect(e1)
end
