--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:51
-- Source DB: cards.cdb
-- Card: Energy Bravery  (ID: 72631243)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Warrior
-- Level: 4
-- ATK 1700 | DEF 1200
-- Scope: OCG / TCG
--
-- Effect Text:
-- Gemini monsters you control that are being treated as Effect Monsters cannot be destroyed by card
-- effects.
--[[ __CARD_HEADER_END__ ]]

--エナジー・ブレイブ
function c72631243.initial_effect(c)
	--indes
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(LOCATION_MZONE,0)
	e1:SetTarget(c72631243.indtg)
	e1:SetValue(1)
	c:RegisterEffect(e1)
end
function c72631243.indtg(e,c)
	return c:IsDualState()
end
