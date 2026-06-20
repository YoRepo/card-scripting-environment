--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 娱乐伙伴 异色眼牛头人  (ID: 10731333)
-- Type: Monster / Effect / Pendulum
-- Attribute: DARK
-- Race: Beast-Warrior
-- Level 4
-- Pendulum Scales: L6 / R6
-- ATK 1200 | DEF 1600
-- Setcode: 10027167
--
-- Effect Text:
-- ←6 【灵摆】 6→
-- ①：自己的「娱乐伙伴」怪兽或者「异色眼」怪兽向守备表示怪兽攻击的场合，给与对方为攻击力超过那个守备力的数值的战斗伤害。
-- 【怪兽效果】
-- ①：自己的灵摆怪兽向对方怪兽攻击的伤害计算时才能发动。那只对方怪兽的攻击力只在那次伤害计算时下降自己场上的「娱乐伙伴」卡以及「异色眼」卡数量×100。
--[[ __CARD_HEADER_END__ ]]

--EMオッドアイズ・ミノタウロス
function c10731333.initial_effect(c)
	aux.EnablePendulumAttribute(c)
	--pierce
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_PIERCE)
	e1:SetRange(LOCATION_PZONE)
	e1:SetTargetRange(LOCATION_MZONE,0)
	e1:SetTarget(c10731333.ptg)
	c:RegisterEffect(e1)
	--atk down
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_ATKCHANGE)
	e2:SetType(EFFECT_TYPE_TRIGGER_O+EFFECT_TYPE_FIELD)
	e2:SetCode(EVENT_PRE_DAMAGE_CALCULATE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCondition(c10731333.atkcon)
	e2:SetOperation(c10731333.atkop)
	c:RegisterEffect(e2)
end
function c10731333.ptg(e,c)
	return c:IsSetCard(0x9f,0x99)
end
function c10731333.atkfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x9f,0x99)
end
function c10731333.atkcon(e,tp,eg,ep,ev,re,r,rp)
	local a=Duel.GetAttacker()
	local d=a:GetBattleTarget()
	local gc=Duel.GetMatchingGroupCount(c10731333.atkfilter,tp,LOCATION_ONFIELD,0,nil)
	return a:IsControler(tp) and a:IsType(TYPE_PENDULUM) and d
		and d:IsFaceup() and not d:IsControler(tp) and gc>0
end
function c10731333.atkop(e,tp,eg,ep,ev,re,r,rp)
	local d=Duel.GetAttacker():GetBattleTarget()
	local gc=Duel.GetMatchingGroupCount(c10731333.atkfilter,tp,LOCATION_ONFIELD,0,nil)
	if d:IsRelateToBattle() and d:IsFaceup() then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_DAMAGE_CAL)
		e1:SetValue(-gc*100)
		d:RegisterEffect(e1)
	end
end
