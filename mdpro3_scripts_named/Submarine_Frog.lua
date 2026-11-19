--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-11-19T23:32:31
-- Source DB: cards.cdb
-- Card: Submarine Frog  (ID: 63948258)
-- Type: Monster / Effect
-- Attribute: WATER
-- Race: Aqua
-- Level: 2
-- ATK 1200 | DEF 600
-- Setcode: 0x12
-- Scope: OCG / TCG
--
-- Effect Text:
-- If this card attacks a Defense Position monster, inflict piercing battle damage to your opponent.
--[[ __CARD_HEADER_END__ ]]

--未知ガエル
function c63948258.initial_effect(c)
	--Pierce
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_PIERCE)
	c:RegisterEffect(e1)
end
