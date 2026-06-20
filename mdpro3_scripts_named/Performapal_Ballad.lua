--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 娱乐伙伴 歌谣蔷薇  (ID: 66768175)
-- Type: Monster / Effect / Pendulum
-- Attribute: EARTH
-- Race: Plant
-- Level 3
-- Pendulum Scales: L2 / R2
-- ATK 500 | DEF 1100
-- Setcode: 159
--
-- Effect Text:
-- ←2 【灵摆】 2→
-- ①：1回合1次，自己的「娱乐伙伴」怪兽和对方的表侧表示怪兽进行战斗的伤害步骤开始时才能发动。那只对方怪兽的攻击力下降600。
-- 【怪兽效果】
-- ①：自己的「娱乐伙伴」怪兽攻击的伤害计算后，以对方场上1只表侧表示怪兽为对象才能发动。那只对方怪兽的攻击力下降那只「娱乐伙伴」怪兽的攻击力数值。
--[[ __CARD_HEADER_END__ ]]

--EMバラード
function c66768175.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c)
	--atk
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_BATTLE_START)
	e1:SetRange(LOCATION_PZONE)
	e1:SetCountLimit(1)
	e1:SetCondition(c66768175.atkcon1)
	e1:SetOperation(c66768175.atkop1)
	c:RegisterEffect(e1)
	--atk
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_ATKCHANGE)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_BATTLED)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCondition(c66768175.atkcon2)
	e2:SetTarget(c66768175.atktg2)
	e2:SetOperation(c66768175.atkop2)
	c:RegisterEffect(e2)
end
function c66768175.atkcon1(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetAttacker()
	local bc=Duel.GetAttackTarget()
	if not bc then return false end
	if tc:IsControler(1-tp) then bc,tc=tc,bc end
	e:SetLabelObject(bc)
	return bc:IsFaceup() and tc:IsFaceup() and tc:IsSetCard(0x9f)
end
function c66768175.atkop1(e,tp,eg,ep,ev,re,r,rp)
	local bc=e:GetLabelObject()
	if bc:IsRelateToBattle() and bc:IsFaceup() and bc:IsControler(1-tp) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(-600)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		bc:RegisterEffect(e1)
	end
end
function c66768175.atkcon2(e,tp,eg,ep,ev,re,r,rp)
	local a=Duel.GetAttacker()
	return a:IsControler(tp) and a:IsSetCard(0x9f)
end
function c66768175.atktg2(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) and chkc:IsFaceup() end
	if chk==0 then return Duel.IsExistingTarget(Card.IsFaceup,tp,0,LOCATION_MZONE,1,nil) end
	Duel.SelectTarget(tp,Card.IsFaceup,tp,0,LOCATION_MZONE,1,1,nil)
end
function c66768175.atkop2(e,tp,eg,ep,ev,re,r,rp)
	local a=Duel.GetAttacker()
	local tc=Duel.GetFirstTarget()
	if a:IsFaceup() and tc:IsFaceup() and tc:IsRelateToEffect(e) then
		local atk=math.max(0,a:GetAttack())
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(-atk)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		tc:RegisterEffect(e1)
	end
end
