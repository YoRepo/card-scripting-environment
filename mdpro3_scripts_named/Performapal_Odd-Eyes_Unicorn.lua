--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: 娱乐伙伴 异色眼独角兽  (ID: 86157908)
-- Type: Monster / Effect / Pendulum
-- Attribute: LIGHT
-- Race: Beast
-- Level 1
-- Pendulum Scales: L8 / R8
-- ATK 100 | DEF 600
-- Setcode: 10027167
--
-- Effect Text:
-- ←8 【灵摆】 8→
-- ①：只在这张卡在灵摆区域存在才有1次，自己的「异色眼」怪兽的攻击宣言时，以那只怪兽以外的自己场上1只「娱乐伙伴」怪兽为对象才能发动。那只攻击怪兽的攻击力直到战斗阶段结束时上升作为对象的怪兽的原本攻击力
-- 数值。
-- 【怪兽效果】
-- ①：这张卡召唤·特殊召唤成功时，以自己墓地1只「娱乐伙伴」怪兽为对象才能发动。自己回复那只怪兽的攻击力数值的基本分。
--[[ __CARD_HEADER_END__ ]]

--EMオッドアイズ・ユニコーン
function c86157908.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c)
	--atk
	local e2=Effect.CreateEffect(c)
	e2:SetProperty(EFFECT_FLAG_NO_TURN_RESET+EFFECT_FLAG_CARD_TARGET)
	e2:SetCategory(CATEGORY_ATKCHANGE)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_ATTACK_ANNOUNCE)
	e2:SetRange(LOCATION_PZONE)
	e2:SetCountLimit(1)
	e2:SetCondition(c86157908.atkcon)
	e2:SetTarget(c86157908.atktg)
	e2:SetOperation(c86157908.atkop)
	c:RegisterEffect(e2)
	--recover
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_RECOVER)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_SUMMON_SUCCESS)
	e3:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_CARD_TARGET)
	e3:SetTarget(c86157908.target)
	e3:SetOperation(c86157908.operation)
	c:RegisterEffect(e3)
	local e4=e3:Clone()
	e4:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e4)
end
function c86157908.atkfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x9f)
end
function c86157908.atkcon(e,tp,eg,ep,ev,re,r,rp)
	local at=Duel.GetAttacker()
	return at:IsControler(tp) and at:IsSetCard(0x99)
end
function c86157908.atktg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local at=Duel.GetAttacker()
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c86157908.atkfilter(chkc) and chkc~=at end
	if chk==0 then return Duel.IsExistingTarget(c86157908.atkfilter,tp,LOCATION_MZONE,0,1,at) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c86157908.atkfilter,tp,LOCATION_MZONE,0,1,1,at)
end
function c86157908.atkop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	local at=Duel.GetAttacker()
	if at:IsFaceup() and at:IsRelateToBattle() and at:IsAttackable() and not at:IsStatus(STATUS_ATTACK_CANCELED)
		and tc:IsFaceup() and tc:IsRelateToEffect(e) then
		local atk=tc:GetBaseAttack()
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(atk)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_BATTLE)
		at:RegisterEffect(e1)
	end
end
function c86157908.filter(c)
	return c:IsSetCard(0x9f) and c:GetAttack()>0
end
function c86157908.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c86157908.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c86157908.filter,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	local g=Duel.SelectTarget(tp,c86157908.filter,tp,LOCATION_GRAVE,0,1,1,nil)
	local atk=g:GetFirst():GetAttack()
	Duel.SetOperationInfo(0,CATEGORY_RECOVER,nil,0,tp,atk)
end
function c86157908.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.Recover(tp,tc:GetAttack(),REASON_EFFECT)
	end
end
