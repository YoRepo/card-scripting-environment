--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:52
-- Source DB: cards.cdb
-- Card: Fortress Whale's Oath  (ID: 77454922)
-- Type: Spell / Ritual
-- Scope: OCG / TCG
--
-- Effect Text:
-- This card is used to Ritual Summon "Fortress Whale".
-- You must also Tribute monsters from your hand or field whose total Levels equal 7 or more.
--[[ __CARD_HEADER_END__ ]]

--要塞クジラの誓い
function c77454922.initial_effect(c)
	aux.AddRitualProcGreaterCode(c,62337487)
end
