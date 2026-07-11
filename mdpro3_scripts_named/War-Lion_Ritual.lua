--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:49
-- Source DB: cards.cdb
-- Card: War-Lion Ritual  (ID: 54539105)
-- Type: Spell / Ritual
-- Scope: OCG / TCG
--
-- Effect Text:
-- This card is used to Ritual Summon "Super War-Lion".
-- You must also Tribute monsters from your hand or field whose total Levels equal 7 or more.
--[[ __CARD_HEADER_END__ ]]

--ライオンの儀式
function c54539105.initial_effect(c)
	aux.AddRitualProcGreaterCode(c,33951077)
end
