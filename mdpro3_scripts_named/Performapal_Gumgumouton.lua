--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: 娱乐伙伴 橡胶绵羊  (ID: 8384771)
-- Type: Monster / Effect / Pendulum
-- Attribute: EARTH
-- Race: Beast
-- Level 5
-- Pendulum Scales: L1 / R1
-- ATK 900 | DEF 2400
-- Setcode: 159
--
-- Effect Text:
-- ←1 【灵摆】 1→
-- ①：1回合1次，自己怪兽和对方怪兽进行战斗的攻击宣言时才能发动。那只自己怪兽不会被那次战斗破坏。
-- 【怪兽效果】
-- ①：1回合1次，自己怪兽和对方怪兽进行战斗的攻击宣言时才能发动。那只自己怪兽不会被那次战斗破坏。
--[[ __CARD_HEADER_END__ ]]

--EMゴムゴムートン
function c8384771.initial_effect(c)
	aux.EnablePendulumAttribute(c)
	--indes
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetCountLimit(1)
	e1:SetRange(LOCATION_PZONE)
	e1:SetCondition(c8384771.condition)
	e1:SetTarget(c8384771.target)
	e1:SetOperation(c8384771.operation1)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetRange(LOCATION_MZONE)
	e2:SetOperation(c8384771.operation2)
	c:RegisterEffect(e2)
end
function c8384771.condition(e,tp,eg,ep,ev,re,r,rp)
	local a=Duel.GetAttacker()
	local d=Duel.GetAttackTarget()
	if not d or a:GetControler()==d:GetControler() then return false end
	if a:IsControler(tp) then e:SetLabelObject(a) else e:SetLabelObject(d) end
	return true
end
function c8384771.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetCard(e:GetLabelObject())
end
function c8384771.operation1(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
		e1:SetValue(1)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_DAMAGE)
		tc:RegisterEffect(e1)
	end
end
function c8384771.operation2(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
		e1:SetValue(1)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_DAMAGE)
		tc:RegisterEffect(e1)
	end
end
