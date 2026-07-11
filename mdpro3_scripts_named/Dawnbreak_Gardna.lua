--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:50
-- Source DB: cards.cdb
-- Card: Dawnbreak Gardna  (ID: 57549932)
-- Type: Monster / Effect / Gemini
-- Attribute: LIGHT
-- Race: Warrior
-- Level: 3
-- ATK 1500 | DEF 500
-- Scope: OCG / TCG
--
-- Effect Text:
-- This card is treated as a Normal Monster while face-up on the field or in the Graveyard.
-- While this card is face-up on the field, you can Normal Summon it to have it be treated as an Effect
-- Monster with this effect:
-- ● The original DEF of this card becomes 2300.
--[[ __CARD_HEADER_END__ ]]

--サンライズ・ガードナー
function c57549932.initial_effect(c)
	aux.EnableDualAttribute(c)
	--change base defense
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(aux.IsDualState)
	e1:SetCode(EFFECT_SET_BASE_DEFENSE)
	e1:SetValue(2300)
	c:RegisterEffect(e1)
end
