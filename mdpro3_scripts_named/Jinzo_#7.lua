--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:44
-- Source DB: cards.cdb
-- Card: Jinzo #7  (ID: 32809211)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Machine
-- Level: 2
-- ATK 500 | DEF 400
-- Setcode: 0xbc
-- Scope: OCG / TCG
--
-- Effect Text:
-- This monster can attack your opponent's Life Points directly.
--[[ __CARD_HEADER_END__ ]]

--人造人間7号
function c32809211.initial_effect(c)
	--direct attack
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_DIRECT_ATTACK)
	c:RegisterEffect(e1)
end
