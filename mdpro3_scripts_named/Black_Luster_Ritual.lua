--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:49
-- Source DB: cards.cdb
-- Card: Black Luster Ritual  (ID: 55761792)
-- Type: Spell / Ritual
-- Setcode: 0xcf
-- Scope: OCG / TCG
--
-- Effect Text:
-- This card is used to Ritual Summon "Black Luster Soldier".
-- You must also Tribute monsters from your hand or field whose total Levels equal 8 or more.
--[[ __CARD_HEADER_END__ ]]

--カオスの儀式
function c55761792.initial_effect(c)
	aux.AddRitualProcGreaterCode(c,5405694)
end
