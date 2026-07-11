--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:50
-- Source DB: cards.cdb
-- Card: Nightmare Horse  (ID: 59290628)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Zombie
-- Level: 2
-- ATK 500 | DEF 400
-- Scope: OCG / TCG
--
-- Effect Text:
-- This card can attack your opponent's Life Points directly even if there is a monster on your
-- opponent's side of the field.
--[[ __CARD_HEADER_END__ ]]

--ナイトメア・ホース
function c59290628.initial_effect(c)
	--direct attack
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_DIRECT_ATTACK)
	c:RegisterEffect(e1)
end
