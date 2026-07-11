--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:50
-- Source DB: cards.cdb
-- Card: Earth Chant  (ID: 59820352)
-- Type: Spell / Ritual
-- Scope: OCG / TCG
--
-- Effect Text:
-- This card can be used to Ritual Summon any EARTH Ritual Monster.
-- You must also Tribute monsters from your hand or field whose total Levels exactly equal the Level of
-- the Ritual Monster you Ritual Summon.
--[[ __CARD_HEADER_END__ ]]

--大地讃頌
function c59820352.initial_effect(c)
	aux.AddRitualProcEqual2(c,c59820352.ritual_filter)
end
function c59820352.ritual_filter(c)
	return c:IsType(TYPE_RITUAL) and c:IsAttribute(ATTRIBUTE_EARTH)
end
