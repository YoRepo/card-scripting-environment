--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 半反击  (ID: 6799227)
-- Type: Trap
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 自己场上存在的怪兽被攻击的场合，那次伤害计算时才能发动。成为攻击对象的1只自己怪兽的攻击力直到结束阶段时上升攻击怪兽的原本攻击力一半的数值。
--[[ __CARD_HEADER_END__ ]]

--ハーフ・カウンター
function c6799227.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_PRE_DAMAGE_CALCULATE)
	e1:SetCondition(c6799227.condition)
	e1:SetTarget(c6799227.target)
	e1:SetOperation(c6799227.activate)
	c:RegisterEffect(e1)
end
function c6799227.condition(e,tp,eg,ep,ev,re,r,rp)
	local t=Duel.GetAttackTarget()
	return t and t:IsControler(tp)
end
function c6799227.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local tg=Duel.GetAttackTarget()
	if chkc then return chkc==tg end
	if chk==0 then return Duel.GetAttacker():IsOnField() and tg:IsCanBeEffectTarget(e) end
	Duel.SetTargetCard(tg)
end
function c6799227.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() then
		local atk=Duel.GetAttacker():GetBaseAttack()
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		e1:SetValue(math.ceil(atk/2))
		tc:RegisterEffect(e1)
	end
end
