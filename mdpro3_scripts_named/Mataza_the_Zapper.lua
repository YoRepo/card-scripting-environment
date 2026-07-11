--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:43
-- Source DB: cards.cdb
-- Card: Mataza the Zapper  (ID: 22609617)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Warrior
-- Level: 3
-- ATK 1300 | DEF 800
-- Scope: OCG / TCG
--
-- Effect Text:
-- This card can make a second attack during each Battle Phase.
-- Control of this face-up card on the field cannot switch.
--[[ __CARD_HEADER_END__ ]]

--不意打ち又佐
function c22609617.initial_effect(c)
	--control
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_CANNOT_CHANGE_CONTROL)
	c:RegisterEffect(e1)
	--double attack
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_EXTRA_ATTACK)
	e2:SetValue(1)
	c:RegisterEffect(e2)
end
