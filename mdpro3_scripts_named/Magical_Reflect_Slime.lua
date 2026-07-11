--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:45
-- Source DB: cards.cdb
-- Card: Magical Reflect Slime  (ID: 3918345)
-- Type: Monster / Effect / Gemini
-- Attribute: WATER
-- Race: Aqua
-- Level: 3
-- ATK 700 | DEF 1200
-- Scope: OCG / TCG
--
-- Effect Text:
-- This card is treated as a Normal Monster while face-up on the field or in the GY.
-- While this card is a Normal Monster on the field, you can Normal Summon it to have it become an
-- Effect Monster with this effect.
-- ● Your opponent takes any battle damage you would have taken from battles involving this card.
--[[ __CARD_HEADER_END__ ]]

--マジック・スライム
function c3918345.initial_effect(c)
	aux.EnableDualAttribute(c)
	--reflect battle dam
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_REFLECT_BATTLE_DAMAGE)
	e1:SetCondition(aux.IsDualState)
	e1:SetValue(1)
	c:RegisterEffect(e1)
end
