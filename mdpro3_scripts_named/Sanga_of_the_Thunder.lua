--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 雷魔神-桑迦  (ID: 25955164)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Thunder
-- Level 7
-- ATK 2600 | DEF 2200
--
-- Effect Text:
-- ①：只在这张卡在场上表侧表示存在才有1次，这张卡被攻击的伤害计算时，以1只攻击怪兽为对象才能发动。那只攻击怪兽的攻击力变成0。
--[[ __CARD_HEADER_END__ ]]

--雷魔神－サンガ
function c25955164.initial_effect(c)
	--atkdown
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(25955164,0))
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EVENT_PRE_DAMAGE_CALCULATE)
	e1:SetProperty(EFFECT_FLAG_NO_TURN_RESET)
	e1:SetCountLimit(1)
	e1:SetCondition(c25955164.condition)
	e1:SetTarget(c25955164.target)
	e1:SetOperation(c25955164.operation)
	c:RegisterEffect(e1)
end
function c25955164.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()~=tp and Duel.GetAttackTarget()==e:GetHandler()
end
function c25955164.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetAttacker():IsCanBeEffectTarget(e) end
	Duel.SetTargetCard(Duel.GetAttacker())
end
function c25955164.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_ATTACK_FINAL)
		e1:SetReset(RESET_PHASE+PHASE_DAMAGE_CAL)
		e1:SetValue(0)
		tc:RegisterEffect(e1)
	end
end
