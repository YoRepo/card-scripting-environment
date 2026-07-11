--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:47
-- Source DB: cards.cdb
-- Card: Tuned Magician  (ID: 47459126)
-- Type: Monster / Effect / Gemini
-- Attribute: WIND
-- Race: Spellcaster
-- Level: 4
-- ATK 1800 | DEF 1600
-- Scope: OCG / TCG
--
-- Effect Text:
-- This card is treated as a Normal Monster while face-up on the field or in the Graveyard.
-- While this card is face-up on the field, you can Normal Summon it to have it be treated as an Effect
-- Monster with this effect:
-- ● This card is treated as a Tuner.
--[[ __CARD_HEADER_END__ ]]

--チューンド・マジシャン
function c47459126.initial_effect(c)
	aux.EnableDualAttribute(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_ADD_TYPE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(aux.IsDualState)
	e1:SetValue(TYPE_TUNER)
	c:RegisterEffect(e1)
end
c47459126.treat_itself_tuner=true
