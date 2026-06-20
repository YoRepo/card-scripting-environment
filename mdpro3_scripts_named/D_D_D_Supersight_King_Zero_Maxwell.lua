--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: DDD 超视王 零·麦克斯韦  (ID: 76029419)
-- Type: Monster / Effect / Pendulum
-- Attribute: DARK
-- Race: Fiend
-- Level 7
-- Pendulum Scales: L4 / R4
-- ATK 2800 | DEF 2500
-- Setcode: 4271
--
-- Effect Text:
-- ←4 【灵摆】 4→
-- 这个卡名的灵摆效果1回合只能使用1次。
-- ①：以场上1只表侧表示怪兽为对象才能发动。那只怪兽的守备力直到回合结束时变成0。
-- 【怪兽效果】
-- ①：这张卡向对方的守备表示怪兽攻击的伤害计算前才能发动。那只对方怪兽的守备力直到伤害步骤结束时变成0。
-- ②：这张卡向守备表示怪兽攻击的场合，给与攻击力超过那个守备力的数值的战斗伤害。
-- ③：这张卡的战斗发生的对自己的战斗伤害变成0。
--[[ __CARD_HEADER_END__ ]]

--DDD超視王ゼロ・マクスウェル
function c76029419.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c)
	--def
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(76029419,0))
	e1:SetCategory(CATEGORY_DEFCHANGE)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetRange(LOCATION_PZONE)
	e1:SetCountLimit(1,76029419)
	e1:SetTarget(c76029419.deftg)
	e1:SetOperation(c76029419.defop)
	c:RegisterEffect(e1)
	--def
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(76029419,1))
	e2:SetCategory(CATEGORY_DEFCHANGE)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_BATTLE_CONFIRM)
	e2:SetCondition(c76029419.defcon2)
	e2:SetOperation(c76029419.defop2)
	c:RegisterEffect(e2)
	--pierce
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_PIERCE)
	c:RegisterEffect(e3)
	--no damage
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetCode(EFFECT_AVOID_BATTLE_DAMAGE)
	e4:SetValue(1)
	c:RegisterEffect(e4)
end
function c76029419.deftg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and aux.nzdef(chkc) end
	if chk==0 then return Duel.IsExistingTarget(aux.nzdef,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,aux.nzdef,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
end
function c76029419.defop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsFaceup() and tc:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_DEFENSE_FINAL)
		e1:SetValue(0)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
	end
end
function c76029419.defcon2(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetAttackTarget()
	e:SetLabelObject(tc)
	return Duel.GetAttacker()==e:GetHandler() and tc and tc:IsPosition(POS_FACEUP_DEFENSE) and tc:GetDefense()>0
end
function c76029419.defop2(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetLabelObject()
	if tc:IsFaceup() and tc:IsRelateToBattle() then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_DEFENSE_FINAL)
		e1:SetValue(0)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_DAMAGE)
		tc:RegisterEffect(e1)
	end
end
