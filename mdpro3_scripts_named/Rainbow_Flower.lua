--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:43
-- Source DB: cards.cdb
-- Card: Rainbow Flower  (ID: 21347810)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Plant
-- Level: 2
-- ATK 400 | DEF 500
-- Scope: OCG / TCG
--
-- Effect Text:
-- This monster may attack your opponent's Life Points directly.
--[[ __CARD_HEADER_END__ ]]

--レインボー・フラワー
function c21347810.initial_effect(c)
	--direct attack
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_DIRECT_ATTACK)
	c:RegisterEffect(e1)
end
