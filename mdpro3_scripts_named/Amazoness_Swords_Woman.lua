--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:53
-- Source DB: cards.cdb
-- Card: Amazoness Swords Woman  (ID: 94004268)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Warrior
-- Level: 4
-- ATK 1500 | DEF 1600
-- Setcode: 0x4
-- Scope: OCG / TCG
--
-- Effect Text:
-- Your opponent takes any battle damage you would have taken from battles involving this card instead.
--[[ __CARD_HEADER_END__ ]]

--アマゾネスの剣士
function c94004268.initial_effect(c)
	--reflect battle dam
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_REFLECT_BATTLE_DAMAGE)
	e1:SetValue(1)
	c:RegisterEffect(e1)
end
