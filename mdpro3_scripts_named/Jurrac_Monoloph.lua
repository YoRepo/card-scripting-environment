--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:45
-- Source DB: cards.cdb
-- Card: Jurrac Monoloph  (ID: 36717258)
-- Type: Monster / Effect / Tuner
-- Attribute: FIRE
-- Race: Dinosaur
-- Level: 3
-- ATK 1500 | DEF 1200
-- Setcode: 0x22
-- Scope: OCG / TCG
--
-- Effect Text:
-- This card can attack all monsters your opponent controls once each.
--[[ __CARD_HEADER_END__ ]]

--ジュラック・モノロフ
function c36717258.initial_effect(c)
	--attack all
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_ATTACK_ALL)
	e1:SetValue(1)
	c:RegisterEffect(e1)
end
