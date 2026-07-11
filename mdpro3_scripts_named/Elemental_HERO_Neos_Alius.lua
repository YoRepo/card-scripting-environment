--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:51
-- Source DB: cards.cdb
-- Card: Elemental HERO Neos Alius  (ID: 69884162)
-- Type: Monster / Effect / Gemini
-- Attribute: LIGHT
-- Race: Warrior
-- Level: 4
-- ATK 1900 | DEF 1300
-- Setcode: 0x3008, 0x9
-- Scope: OCG / TCG
--
-- Effect Text:
-- This card is treated as a Normal Monster while face-up on the field or in the GY.
-- While this card is a Normal Monster on the field, you can Normal Summon it to have it become an
-- Effect Monster with this effect.
-- ● This card's name becomes "Elemental HERO Neos" while on the field.
--[[ __CARD_HEADER_END__ ]]

--E・HERO アナザー・ネオス
function c69884162.initial_effect(c)
	aux.EnableDualAttribute(c)
	--code
	aux.EnableChangeCode(c,89943723,LOCATION_MZONE,aux.IsDualState)
end
