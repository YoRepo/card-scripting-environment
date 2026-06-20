--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:24
-- Card: 英豪前卫  (ID: 21924381)
-- Type: Trap
-- ATK 0 | DEF 0
-- Setcode: 111
--
-- Effect Text:
-- 自己场上的名字带有「英豪」的怪兽被选择作为攻击对象时，选择自己场上1只其他的4星以下的名字带有「英豪」的怪兽才能发动。选择的怪兽的攻击力直到战斗阶段结束时变成2倍，把攻击对象转移为选择的怪兽进行伤害计
-- 算。双方怪兽不会被这次战斗破坏。
--[[ __CARD_HEADER_END__ ]]

--ヒロイック・アドバンス
function c21924381.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_BE_BATTLE_TARGET)
	e1:SetCondition(c21924381.condition)
	e1:SetTarget(c21924381.target)
	e1:SetOperation(c21924381.activate)
	c:RegisterEffect(e1)
end
function c21924381.condition(e,tp,eg,ep,ev,re,r,rp)
	local d=Duel.GetAttackTarget()
	return d:IsFaceup() and d:IsControler(tp) and d:IsSetCard(0x6f)
end
function c21924381.filter(c)
	return c:IsFaceup() and c:IsLevelBelow(4) and c:IsSetCard(0x6f)
end
function c21924381.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c21924381.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c21924381.filter,tp,LOCATION_MZONE,0,1,Duel.GetAttackTarget()) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,c21924381.filter,tp,LOCATION_MZONE,0,1,1,Duel.GetAttackTarget())
	Duel.GetAttacker():CreateEffectRelation(e)
end
function c21924381.activate(e,tp,eg,ep,ev,re,r,rp)
	local a=Duel.GetAttacker()
	local tc=Duel.GetFirstTarget()
	if tc:IsFaceup() and tc:IsRelateToEffect(e) and not tc:IsImmuneToEffect(e)
		and a:IsAttackable() and a:IsRelateToEffect(e) and not a:IsImmuneToEffect(e)then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_ATTACK_FINAL)
		e1:SetValue(tc:GetAttack()*2)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_BATTLE)
		tc:RegisterEffect(e1)
		local e2=Effect.CreateEffect(e:GetHandler())
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
		e2:SetValue(1)
		e2:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_DAMAGE)
		tc:RegisterEffect(e2)
		local e3=e2:Clone()
		a:RegisterEffect(e3)
		Duel.CalculateDamage(a,tc)
	end
end
