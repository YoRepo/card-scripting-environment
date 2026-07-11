--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:52
-- Source DB: cards.cdb
-- Card: Gora Turtle  (ID: 80233946)
-- Type: Monster / Effect
-- Attribute: WATER
-- Race: Aqua
-- Level: 3
-- ATK 1100 | DEF 1100
-- Scope: OCG / TCG
--
-- Effect Text:
-- As long as this card remains face-up on the field, monsters with an ATK equal to 1900 or more cannot
-- declare an attack.
--[[ __CARD_HEADER_END__ ]]

--ゴラ・タートル
function c80233946.initial_effect(c)
	--cannot attack
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_ATTACK_ANNOUNCE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e1:SetTarget(c80233946.atktarget)
	c:RegisterEffect(e1)
end
function c80233946.atktarget(e,c)
	return c:IsAttackAbove(1900)
end
