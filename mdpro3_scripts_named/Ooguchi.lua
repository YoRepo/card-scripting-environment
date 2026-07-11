--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:50
-- Source DB: cards.cdb
-- Card: Ooguchi  (ID: 58861941)
-- Type: Monster / Effect
-- Attribute: WATER
-- Race: Aqua
-- Level: 1
-- ATK 300 | DEF 250
-- Scope: OCG / TCG
--
-- Effect Text:
-- This monster may attack your opponent's Life Points directly.
--[[ __CARD_HEADER_END__ ]]

--ラージマウス
function c58861941.initial_effect(c)
	--direct attack
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_DIRECT_ATTACK)
	c:RegisterEffect(e1)
end
