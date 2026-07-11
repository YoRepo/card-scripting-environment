--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:53
-- Source DB: cards.cdb
-- Card: Chthonian Emperor Dragon  (ID: 95888876)
-- Type: Monster / Effect / Gemini
-- Attribute: FIRE
-- Race: Dragon
-- Level: 6
-- ATK 2400 | DEF 1500
-- Scope: OCG / TCG
--
-- Effect Text:
-- This card is treated as a Normal Monster while face-up on the field or in the Graveyard.
-- While this card is face-up on the field, you can Normal Summon it to have it be treated as an Effect
-- Monster with this effect:
-- ● This card can attack twice during the same Battle Phase.
--[[ __CARD_HEADER_END__ ]]

--ヘルカイザー・ドラゴン
function c95888876.initial_effect(c)
	aux.EnableDualAttribute(c)
	--double atk
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_EXTRA_ATTACK)
	e1:SetValue(1)
	e1:SetCondition(aux.IsDualState)
	c:RegisterEffect(e1)
end
