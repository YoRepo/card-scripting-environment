--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 决斗融合  (ID: 43225434)
-- Type: Spell / Continuous
-- ATK 0 | DEF 0
-- Setcode: 70
--
-- Effect Text:
-- 「决斗融合」在1回合只能发动1张。
-- ①：自己场上的融合怪兽和对方怪兽进行战斗的攻击宣言时才能发动。那只自己怪兽的攻击力直到伤害步骤结束时上升进行战斗的对方怪兽的攻击力数值。
--[[ __CARD_HEADER_END__ ]]

--決闘融合－バトル・フュージョン
function c43225434.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetCountLimit(1,43225434+EFFECT_COUNT_CODE_OATH)
	e1:SetCondition(c43225434.condition)
	e1:SetOperation(c43225434.activate)
	c:RegisterEffect(e1)
end
function c43225434.condition(e,tp,eg,ep,ev,re,r,rp)
	local a=Duel.GetAttacker()
	local at=Duel.GetAttackTarget()
	return at and ((a:IsControler(tp) and a:IsType(TYPE_FUSION))
		or (at:IsControler(tp) and at:IsFaceup() and at:IsType(TYPE_FUSION)))
end
function c43225434.activate(e,tp,eg,ep,ev,re,r,rp)
	local a=Duel.GetAttacker()
	local at=Duel.GetAttackTarget()
	if a:IsControler(1-tp) then a,at=at,a end
	if not a:IsRelateToBattle() or a:IsFacedown() or not at:IsRelateToBattle() or at:IsFacedown() then return end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_DAMAGE)
	e1:SetValue(at:GetAttack())
	a:RegisterEffect(e1)
end
