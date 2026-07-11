--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:52
-- Source DB: cards.cdb
-- Card: Comrade Swordsman of Landstar  (ID: 83602069)
-- Type: Monster / Effect / Tuner
-- Attribute: EARTH
-- Race: Warrior
-- Level: 3
-- ATK 500 | DEF 1200
-- Scope: OCG / TCG
--
-- Effect Text:
-- All Warrior-Type monsters you control gain 400 ATK.
--[[ __CARD_HEADER_END__ ]]

--共闘するランドスターの剣士
function c83602069.initial_effect(c)
	--atk
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(LOCATION_MZONE,0)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetTarget(aux.TargetBoolFunction(Card.IsRace,RACE_WARRIOR))
	e1:SetValue(400)
	c:RegisterEffect(e1)
end
