--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:54
-- Source DB: cards.cdb
-- Card: White Dragon Ritual  (ID: 9786492)
-- Type: Spell / Ritual
-- Scope: OCG / TCG
--
-- Effect Text:
-- This card is used to Ritual Summon "Paladin of White Dragon".
-- You must also Tribute monsters from your hand or field whose total Levels equal 4 or more.
--[[ __CARD_HEADER_END__ ]]

--白竜降臨
function c9786492.initial_effect(c)
	aux.AddRitualProcGreaterCode(c,73398797)
end
