--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:52
-- Source DB: cards.cdb
-- Card: Mad Sword Beast  (ID: 79870141)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Dinosaur
-- Level: 4
-- ATK 1400 | DEF 1200
-- Scope: OCG / TCG
--
-- Effect Text:
-- If this card attacks a Defense Position monster, inflict piercing battle damage.
--[[ __CARD_HEADER_END__ ]]

--猛進する剣角獣
function c79870141.initial_effect(c)
	--pierce
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_PIERCE)
	c:RegisterEffect(e1)
end
