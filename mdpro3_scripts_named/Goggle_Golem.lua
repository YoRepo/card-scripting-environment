--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:43
-- Source DB: cards.cdb
-- Card: Goggle Golem  (ID: 21155323)
-- Type: Monster / Effect / Gemini
-- Attribute: EARTH
-- Race: Rock
-- Level: 4
-- ATK 1500 | DEF 500
-- Scope: OCG / TCG
--
-- Effect Text:
-- This card is treated as a Normal Monster while face-up on the field or in the Graveyard.
-- While this card is face-up on the field, you can Normal Summon it to have it be treated as an Effect
-- Monster with this effect:
-- ● The original ATK of this card becomes 2100.
--[[ __CARD_HEADER_END__ ]]

--巨人ゴーグル
function c21155323.initial_effect(c)
	aux.EnableDualAttribute(c)
	--change base attack
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(aux.IsDualState)
	e1:SetCode(EFFECT_SET_BASE_ATTACK)
	e1:SetValue(2100)
	c:RegisterEffect(e1)
end
