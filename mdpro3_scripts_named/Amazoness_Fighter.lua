--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:49
-- Source DB: cards.cdb
-- Card: Amazoness Fighter  (ID: 55821894)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Warrior
-- Level: 4
-- ATK 1500 | DEF 1300
-- Setcode: 0x4
-- Scope: OCG / TCG
--
-- Effect Text:
-- You take no battle damage from attacks involving this card.
--[[ __CARD_HEADER_END__ ]]

--アマゾネスの格闘戦士
function c55821894.initial_effect(c)
	--battle dam 0
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_AVOID_BATTLE_DAMAGE)
	e1:SetValue(1)
	c:RegisterEffect(e1)
end
