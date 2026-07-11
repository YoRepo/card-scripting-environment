--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:43
-- Source DB: cards.cdb
-- Card: Hayabusa Knight  (ID: 21015833)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Warrior
-- Level: 3
-- ATK 1000 | DEF 700
-- Scope: OCG / TCG
--
-- Effect Text:
-- This card can make a second attack during each Battle Phase.
--[[ __CARD_HEADER_END__ ]]

--隼の騎士
function c21015833.initial_effect(c)
	--double attack
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_EXTRA_ATTACK)
	e1:SetValue(1)
	c:RegisterEffect(e1)
end
