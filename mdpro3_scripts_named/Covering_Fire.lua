--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 援护射击  (ID: 74458486)
-- Type: Trap
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 对方怪兽攻击自己场上怪兽的场合，伤害步骤时发动。被攻击的自己怪兽的攻击力上升自己场上表侧表示存在的另外1只怪兽的攻击力的数值。
--[[ __CARD_HEADER_END__ ]]

--援護射撃
function c74458486.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DAMAGE_STEP)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(TIMING_DAMAGE_STEP)
	e1:SetCondition(c74458486.condition)
	e1:SetTarget(c74458486.target)
	e1:SetOperation(c74458486.activate)
	c:RegisterEffect(e1)
end
function c74458486.condition(e,tp,eg,ep,ev,re,r,rp)
	local phase=Duel.GetCurrentPhase()
	return phase==PHASE_DAMAGE and not Duel.IsDamageCalculated()
		and Duel.GetAttacker():IsControler(1-tp) and Duel.GetAttackTarget()
end
function c74458486.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and chkc:IsFaceup() end
	if chk==0 then return Duel.IsExistingTarget(Card.IsFaceup,tp,LOCATION_MZONE,0,1,Duel.GetAttackTarget()) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,Card.IsFaceup,tp,LOCATION_MZONE,0,1,1,Duel.GetAttackTarget())
end
function c74458486.activate(e,tp,eg,ep,ev,re,r,rp)
	local at=Duel.GetAttackTarget()
	local tc=Duel.GetFirstTarget()
	if at:IsFaceup() and at:IsRelateToBattle() and tc:IsRelateToEffect(e) and tc:IsFaceup() then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_DAMAGE_CAL)
		e1:SetValue(tc:GetAttack())
		at:RegisterEffect(e1)
	end
end
