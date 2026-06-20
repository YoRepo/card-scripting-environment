--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:26
-- Card: 娱乐伙伴 喇叭熊猫  (ID: 32787239)
-- Type: Monster / Effect / Pendulum
-- Attribute: EARTH
-- Race: Beast
-- Level 3
-- Pendulum Scales: L3 / R3
-- ATK 800 | DEF 800
-- Setcode: 159
--
-- Effect Text:
-- ←3 【灵摆】 3→
-- ①：1回合1次，自己主要阶段才能发动。这张卡的灵摆刻度上升1（最多到12）。
-- 【怪兽效果】
-- 「娱乐伙伴 喇叭熊猫」的怪兽效果1回合只能使用1次。
-- ①：自己的灵摆怪兽被选择作为攻击对象时才能发动。那次攻击无效。
--[[ __CARD_HEADER_END__ ]]

--EMラ・パンダ
function c32787239.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c)
	--scale change
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(32787239,0))
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_PZONE)
	e2:SetCountLimit(1)
	e2:SetTarget(c32787239.sctg)
	e2:SetOperation(c32787239.scop)
	c:RegisterEffect(e2)
	--negate attack
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(32787239,1))
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_BE_BATTLE_TARGET)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1,32787239)
	e3:SetCondition(c32787239.condition)
	e3:SetOperation(c32787239.operation)
	c:RegisterEffect(e3)
end
function c32787239.sctg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():GetLeftScale()<12 end
end
function c32787239.scop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) or c:GetLeftScale()>=12 then return end
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_LSCALE)
	e1:SetValue(1)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_DISABLE)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_UPDATE_RSCALE)
	c:RegisterEffect(e2)
end
function c32787239.condition(e,tp,eg,ep,ev,re,r,rp)
	local d=Duel.GetAttackTarget()
	return d and d:IsControler(tp) and d:IsFaceup() and d:IsType(TYPE_PENDULUM)
end
function c32787239.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateAttack()
end
