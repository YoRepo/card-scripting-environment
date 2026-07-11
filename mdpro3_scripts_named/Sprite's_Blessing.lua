--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:45
-- Source DB: cards.cdb
-- Card: Sprite's Blessing  (ID: 37626500)
-- Type: Spell / Ritual
-- Scope: OCG / TCG
--
-- Effect Text:
-- This card can be used to Ritual Summon any LIGHT Ritual Monster.
-- You must also Tribute monsters from your hand or field whose total Levels exactly equal the Level of
-- the Ritual Monster you Ritual Summon.
--[[ __CARD_HEADER_END__ ]]

--精霊の祝福
function c37626500.initial_effect(c)
	aux.AddRitualProcEqual2(c,c37626500.ritual_filter)
end
function c37626500.ritual_filter(c)
	return c:IsType(TYPE_RITUAL) and c:IsAttribute(ATTRIBUTE_LIGHT)
end
