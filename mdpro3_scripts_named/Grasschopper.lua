--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:53
-- Source DB: cards.cdb
-- Card: Grasschopper  (ID: 95166228)
-- Type: Monster / Effect / Gemini
-- Attribute: EARTH
-- Race: Insect
-- Level: 5
-- ATK 2350 | DEF 1000
-- Scope: OCG / TCG
--
-- Effect Text:
-- This card is treated as a Normal Monster while face-up on the field or in the Graveyard.
-- While this card is face-up on the field, you can Normal Summon it to have it be treated as an Effect
-- Monster with this effect:
-- ● This card can attack all monsters your opponent controls once each.
--[[ __CARD_HEADER_END__ ]]

--ヴァリュアブル・アーマー
function c95166228.initial_effect(c)
	aux.EnableDualAttribute(c)
	--attack all
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_ATTACK_ALL)
	e1:SetCondition(aux.IsDualState)
	e1:SetValue(1)
	c:RegisterEffect(e1)
end
