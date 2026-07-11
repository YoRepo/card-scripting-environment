--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:51
-- Source DB: cards.cdb
-- Card: Mind on Air  (ID: 66690411)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Spellcaster
-- Level: 6
-- ATK 1000 | DEF 1600
-- Scope: OCG / TCG
--
-- Effect Text:
-- Your opponent must play with their hand revealed.
--[[ __CARD_HEADER_END__ ]]

--マインド・オン・エア
function c66690411.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_PUBLIC)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(0,LOCATION_HAND)
	c:RegisterEffect(e1)
end
