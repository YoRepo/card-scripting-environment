--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:50
-- Source DB: cards.cdb
-- Card: Gravekeeper's Spear Soldier  (ID: 63695531)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Spellcaster
-- Level: 4
-- ATK 1500 | DEF 1000
-- Setcode: 0x2e
-- Scope: OCG / TCG
--
-- Effect Text:
-- If this card attacks a Defense Position monster, inflict piercing battle damage to your opponent.
--[[ __CARD_HEADER_END__ ]]

--墓守の長槍兵
function c63695531.initial_effect(c)
	--pierce
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_PIERCE)
	c:RegisterEffect(e1)
end
