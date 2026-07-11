--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:54
-- Source DB: cards.cdb
-- Card: Gravekeeper's Vassal  (ID: 99690140)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Spellcaster
-- Level: 3
-- ATK 700 | DEF 500
-- Setcode: 0x2e
-- Scope: OCG / TCG
--
-- Effect Text:
-- Any battle damage this card inflicts to your opponent is treated as effect damage instead.
--[[ __CARD_HEADER_END__ ]]

--墓守の従者
function c99690140.initial_effect(c)
	--battle damage to effect damage
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_BATTLE_DAMAGE_TO_EFFECT)
	c:RegisterEffect(e1)
end
