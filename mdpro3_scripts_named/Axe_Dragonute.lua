--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:52
-- Source DB: cards.cdb
-- Card: Axe Dragonute  (ID: 84914462)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Dragon
-- Level: 4
-- ATK 2000 | DEF 1200
-- Scope: OCG / TCG
--
-- Effect Text:
-- If this card attacks, it is changed to Defense Position at the end of the Damage Step.
--[[ __CARD_HEADER_END__ ]]

--アックス・ドラゴニュート
function c84914462.initial_effect(c)
	--to defense
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_DAMAGE_STEP_END)
	e1:SetCondition(c84914462.poscon)
	e1:SetOperation(c84914462.posop)
	c:RegisterEffect(e1)
end
function c84914462.poscon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler()==Duel.GetAttacker() and e:GetHandler():IsRelateToBattle()
end
function c84914462.posop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsAttackPos() then
		Duel.ChangePosition(c,POS_FACEUP_DEFENSE)
	end
end
