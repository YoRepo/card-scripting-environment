--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:50
-- Source DB: cards.cdb
-- Card: Queen's Double  (ID: 5901497)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Warrior
-- Level: 1
-- ATK 350 | DEF 300
-- Scope: OCG / TCG
--
-- Effect Text:
-- This monster may attack your opponent's Life Points directly.
--[[ __CARD_HEADER_END__ ]]

--女王の影武者
function c5901497.initial_effect(c)
	--direct attack
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_DIRECT_ATTACK)
	c:RegisterEffect(e1)
end
