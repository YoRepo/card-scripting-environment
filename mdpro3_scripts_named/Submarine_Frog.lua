--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:50
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
-- During battle between this attacking card and a Defense Position monster whose DEF is lower than the
-- ATK of this card, inflict the difference as Battle Damage to your opponent.
--[[ __CARD_HEADER_END__ ]]

--未知ガエル
function c63948258.initial_effect(c)
	--Pierce
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_PIERCE)
	c:RegisterEffect(e1)
end
