--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 娱乐伙伴 灯泡萤火虫  (ID: 12255007)
-- Type: Monster / Effect / Pendulum
-- Attribute: LIGHT
-- Race: Insect
-- Level 4
-- Pendulum Scales: L5 / R5
-- ATK 1200 | DEF 1600
-- Setcode: 159
--
-- Effect Text:
-- ←5 【灵摆】 5→
-- ①：1回合1次，对方怪兽的攻击宣言时把自己场上1只「娱乐伙伴」怪兽解放才能发动。那次攻击无效，那之后战斗阶段结束。
-- 【怪兽效果】
-- ①：只要这张卡在怪兽区域存在，自己场上的「娱乐伙伴」怪兽或者「异色眼」怪兽攻击的场合，对方直到伤害步骤结束时魔法·陷阱卡不能发动。
--[[ __CARD_HEADER_END__ ]]

--EMホタルクス
function c12255007.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c)
	--actlimit
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EFFECT_CANNOT_ACTIVATE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(0,1)
	e1:SetValue(c12255007.aclimit)
	e1:SetCondition(c12255007.actcon)
	c:RegisterEffect(e1)
	--negate attack
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetRange(LOCATION_PZONE)
	e2:SetCode(EVENT_ATTACK_ANNOUNCE)
	e2:SetCountLimit(1)
	e2:SetCondition(c12255007.condition)
	e2:SetCost(c12255007.cost)
	e2:SetOperation(c12255007.operation)
	c:RegisterEffect(e2)
end
function c12255007.aclimit(e,re,tp)
	return re:IsHasType(EFFECT_TYPE_ACTIVATE)
end
function c12255007.actcon(e)
	local tc=Duel.GetAttacker()
	local tp=e:GetHandlerPlayer()
	return tc and tc:IsControler(tp) and tc:IsSetCard(0x9f,0x99)
end
function c12255007.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetAttacker():IsControler(1-tp)
end
function c12255007.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckReleaseGroup(tp,Card.IsSetCard,1,nil,0x9f) end
	local g=Duel.SelectReleaseGroup(tp,Card.IsSetCard,1,1,nil,0x9f)
	Duel.Release(g,REASON_COST)
end
function c12255007.operation(e,tp,eg,ep,ev,re,r,rp)
	if Duel.NegateAttack() then
		Duel.BreakEffect()
		Duel.SkipPhase(1-tp,PHASE_BATTLE,RESET_PHASE+PHASE_BATTLE_STEP,1)
	end
end
