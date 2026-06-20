--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 二重巴塞舞姿  (ID: 79997591)
-- Type: Trap
-- ATK 0 | DEF 0
--
-- Effect Text:
-- ①：对方怪兽向自己场上的表侧攻击表示怪兽攻击宣言时才能发动。给与对方为攻击对象怪兽的攻击力数值的伤害，那只对方怪兽的攻击变成向自己的直接攻击。那只自己怪兽在下次的自己回合可以直接攻击。
--[[ __CARD_HEADER_END__ ]]

--ドゥーブルパッセ
function c79997591.initial_effect(c)
	--change battle target
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(79997591,0))
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetCondition(c79997591.cbcon)
	e1:SetTarget(c79997591.cbtg)
	e1:SetOperation(c79997591.cbop)
	c:RegisterEffect(e1)
end
function c79997591.cbcon(e,tp,eg,ep,ev,re,r,rp)
	local bt=Duel.GetAttackTarget()
	return bt and bt:IsLocation(LOCATION_MZONE) and bt:IsPosition(POS_FACEUP_ATTACK) and bt:IsControler(tp)
end
function c79997591.cbtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return not Duel.GetAttacker():IsHasEffect(EFFECT_CANNOT_DIRECT_ATTACK) end
end
function c79997591.cbop(e,tp,eg,ep,ev,re,r,rp)
	local at=Duel.GetAttacker()
	local bt=Duel.GetAttackTarget()
	if not (bt:IsRelateToBattle() and bt:IsControler(tp)) then return end
	if at:IsAttackable() and not at:IsStatus(STATUS_ATTACK_CANCELED) and Duel.Damage(1-tp,bt:GetAttack(),REASON_EFFECT)>0 then
		Duel.ChangeAttackTarget(nil)
	end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_DIRECT_ATTACK)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END+RESET_SELF_TURN)
	bt:RegisterEffect(e1)
end
