--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:52
-- Source DB: cards.cdb
-- Card: Wind-Up Knight  (ID: 80538728)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Warrior
-- Level: 4
-- ATK 1800 | DEF 1200
-- Setcode: 0x58
-- Scope: OCG / TCG
--
-- Effect Text:
-- When a face-up "Wind-Up" monster you control is targeted for an attack: You can negate the attack.
-- This effect can only be used once while this card is face-up on the field.
--[[ __CARD_HEADER_END__ ]]

--ゼンマイナイト
function c80538728.initial_effect(c)
	--negate attack
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(80538728,0))
	e1:SetProperty(EFFECT_FLAG_NO_TURN_RESET)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_BE_BATTLE_TARGET)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCondition(c80538728.condition)
	e1:SetOperation(c80538728.operation)
	c:RegisterEffect(e1)
end
function c80538728.condition(e,tp,eg,ep,ev,re,r,rp)
	local d=Duel.GetAttackTarget()
	return d and d:IsControler(tp) and d:IsFaceup() and d:IsSetCard(0x58)
end
function c80538728.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateAttack()
end
