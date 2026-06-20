--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:26
-- Card: 交叉反击  (ID: 37083210)
-- Type: Trap
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 受攻击的守备表示怪兽的守备力，比对方攻击怪兽的攻击力高的场合，给与对方的战斗伤害变成2倍。伤害计算后那只攻击怪兽破坏。
--[[ __CARD_HEADER_END__ ]]

--クロスカウンター
function c37083210.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(TIMING_DAMAGE_STEP)
	e1:SetCondition(c37083210.condition)
	e1:SetOperation(c37083210.activate)
	c:RegisterEffect(e1)
end
function c37083210.condition(e,tp,eg,ep,ev,re,r,rp)
	local a=Duel.GetAttacker()
	local at=Duel.GetAttackTarget()
	return Duel.GetCurrentPhase()==PHASE_DAMAGE and not Duel.IsDamageCalculated()
		and a:IsControler(1-tp) and at and at:IsPosition(POS_FACEUP_DEFENSE) and a:GetAttack()<at:GetDefense()
end
function c37083210.activate(e,tp,eg,ep,ev,re,r,rp)
	local at=Duel.GetAttackTarget()
	if at:IsFaceup() and at:IsRelateToBattle() then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CHANGE_BATTLE_DAMAGE)
		e1:SetCondition(c37083210.dcon)
		e1:SetValue(aux.ChangeBattleDamage(1,DOUBLE_DAMAGE))
		e1:SetReset(RESET_PHASE+PHASE_DAMAGE)
		at:RegisterEffect(e1)
		local e2=Effect.CreateEffect(e:GetHandler())
		e2:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
		e2:SetCode(EVENT_BATTLED)
		e2:SetOperation(c37083210.desop)
		e2:SetReset(RESET_PHASE+PHASE_DAMAGE)
		Duel.RegisterEffect(e2,tp)
	end
end
function c37083210.dcon(e)
	local c=e:GetHandler()
	return Duel.GetAttackTarget()==c
end
function c37083210.desop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetAttacker():IsRelateToBattle() then
		Duel.Destroy(Duel.GetAttacker(),REASON_EFFECT)
	end
end
