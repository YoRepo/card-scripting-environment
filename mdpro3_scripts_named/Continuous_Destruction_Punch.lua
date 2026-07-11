--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:51
-- Source DB: cards.cdb
-- Card: Continuous Destruction Punch  (ID: 68057622)
-- Type: Spell / Continuous
-- Scope: OCG / TCG
--
-- Effect Text:
-- If the DEF of the attacked Defense Position monster on your side of the field is higher than the ATK
-- of the attacking monster on your opponent's side of the field, destroy the attacking monster.
-- Damage calculation is applied normally.
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
