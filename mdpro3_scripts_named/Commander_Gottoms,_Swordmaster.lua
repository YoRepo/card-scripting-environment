--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:49
-- Source DB: cards.cdb
-- Card: Commander Gottoms, Swordmaster  (ID: 53388413)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Beast-Warrior
-- Level: 6
-- ATK 2100 | DEF 1600
-- Setcode: 0xb0
-- Scope: OCG / TCG
--
-- Effect Text:
-- All face-up "Saber" monsters you control gain 400 ATK.
--[[ __CARD_HEADER_END__ ]]

--総剣司令 ガトムズ
function c53388413.initial_effect(c)
	--atk
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(LOCATION_MZONE,0)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetTarget(aux.TargetBoolFunction(Card.IsSetCard,0xd))
	e1:SetValue(400)
	c:RegisterEffect(e1)
end
