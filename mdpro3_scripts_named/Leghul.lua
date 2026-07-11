--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:42
-- Source DB: cards.cdb
-- Card: Leghul  (ID: 12472242)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Insect
-- Level: 1
-- ATK 300 | DEF 350
-- Scope: OCG / TCG
--
-- Effect Text:
-- This monster may attack your opponent's Life Points directly.
--[[ __CARD_HEADER_END__ ]]

--レッグル
function c12472242.initial_effect(c)
	--direct attack
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_DIRECT_ATTACK)
	c:RegisterEffect(e1)
end
