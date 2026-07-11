--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:50
-- Source DB: cards.cdb
-- Card: Elemental HERO Bladedge  (ID: 59793705)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Warrior
-- Level: 7
-- ATK 2600 | DEF 1800
-- Setcode: 0x3008
-- Scope: OCG / TCG
--
-- Effect Text:
-- If this card attacks a Defense Position monster, inflict piercing battle damage.
--[[ __CARD_HEADER_END__ ]]

--E・HERO エッジマン
function c59793705.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_PIERCE)
	c:RegisterEffect(e1)
end
