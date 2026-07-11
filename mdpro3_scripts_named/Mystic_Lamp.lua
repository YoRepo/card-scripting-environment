--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:54
-- Source DB: cards.cdb
-- Card: Mystic Lamp  (ID: 98049915)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Spellcaster
-- Level: 1
-- ATK 400 | DEF 300
-- Scope: OCG / TCG
--
-- Effect Text:
-- This monster can attack your opponent's Life Points directly.
--[[ __CARD_HEADER_END__ ]]

--魔法のランプ
function c98049915.initial_effect(c)
	--direct attack
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_DIRECT_ATTACK)
	c:RegisterEffect(e1)
end
