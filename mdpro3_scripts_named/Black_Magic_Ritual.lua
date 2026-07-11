--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:52
-- Source DB: cards.cdb
-- Card: Black Magic Ritual  (ID: 76792184)
-- Type: Spell / Ritual
-- Setcode: 0xcf
-- Scope: OCG / TCG
--
-- Effect Text:
-- This card is used to Ritual Summon "Magician of Black Chaos".
-- You must also Tribute monsters from your hand or field whose total Levels equal 8 or more.
--[[ __CARD_HEADER_END__ ]]

--カオス－黒魔術の儀式
function c76792184.initial_effect(c)
	aux.AddRitualProcGreaterCode(c,30208479)
end
