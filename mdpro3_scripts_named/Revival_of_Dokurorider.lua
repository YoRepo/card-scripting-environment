--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:44
-- Source DB: cards.cdb
-- Card: Revival of Dokurorider  (ID: 31066283)
-- Type: Spell / Ritual
-- Scope: OCG / TCG
--
-- Effect Text:
-- This card is used to Ritual Summon "Dokurorider".
-- You must also Tribute monsters from your hand or field whose total Levels equal 6 or more.
--[[ __CARD_HEADER_END__ ]]

--スカルライダーの復活
function c31066283.initial_effect(c)
	aux.AddRitualProcGreaterCode(c,99721536)
end
