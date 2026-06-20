--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 反击机枪拳  (ID: 68057622)
-- Type: Spell / Equip
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 若被攻击的守备怪兽的守备力比对方攻击怪兽的攻击力高，则这只攻击怪兽被破坏。
--[[ __CARD_HEADER_END__ ]]

--カウンターマシンガンパンチ
function c68057622.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--destroy
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_DAMAGE_STEP_END)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCondition(c68057622.descon)
	e2:SetOperation(c68057622.desop)
	c:RegisterEffect(e2)
end
function c68057622.descon(e,tp,eg,ep,ev,re,r,rp)
	local a=Duel.GetAttacker()
	local at=Duel.GetAttackTarget()
	return at and a:IsControler(1-tp) and a:IsRelateToBattle()
		and at:IsDefensePos() and at:IsRelateToBattle() and a:GetAttack()<at:GetDefense()
end
function c68057622.desop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Destroy(Duel.GetAttacker(),REASON_EFFECT)
end
