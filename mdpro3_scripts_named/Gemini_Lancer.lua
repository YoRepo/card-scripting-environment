--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:44
-- Source DB: cards.cdb
-- Card: Gemini Lancer  (ID: 26254876)
-- Type: Monster / Effect / Gemini
-- Attribute: WATER
-- Race: Sea Serpent
-- Level: 4
-- ATK 1800 | DEF 1400
-- Scope: OCG / TCG
--
-- Effect Text:
-- This card is treated as a Normal Monster while face-up on the field or in the Graveyard.
-- While this card is face-up on the field, you can Normal Summon it to have it be treated as an Effect
-- Monster with this effect:
-- ● During battle between this attacking card and a Defense Position monster whose DEF is lower than
-- the ATK of this card, inflict the difference as Battle Damage to your opponent.
--[[ __CARD_HEADER_END__ ]]

--デュアル・ランサー
function c26254876.initial_effect(c)
	aux.EnableDualAttribute(c)
	--pierce
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_PIERCE)
	e1:SetCondition(aux.IsDualState)
	c:RegisterEffect(e1)
end
