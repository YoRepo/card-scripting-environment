--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:48
-- Source DB: cards.cdb
-- Card: Genex Turbine  (ID: 52222372)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Machine
-- Level: 4
-- ATK 1400 | DEF 1300
-- Setcode: 0x2
-- Scope: OCG / TCG
--
-- Effect Text:
-- While you control this face-up card, all face-up "Genex" monsters you control gain 400 ATK.
--[[ __CARD_HEADER_END__ ]]

--タービン・ジェネクス
function c52222372.initial_effect(c)
	--atk
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(LOCATION_MZONE,0)
	e1:SetTarget(aux.TargetBoolFunction(Card.IsSetCard,0x2))
	e1:SetValue(400)
	c:RegisterEffect(e1)
end
