--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:45
-- Source DB: cards.cdb
-- Card: Resurrection of Chakra  (ID: 39399168)
-- Type: Spell / Ritual
-- Scope: OCG / TCG
--
-- Effect Text:
-- This card is used to Ritual Summon "Chakra".
-- You must also Tribute monsters from your hand or field whose total Levels equal 7 or more.
--[[ __CARD_HEADER_END__ ]]

--チャクラの復活
function c39399168.initial_effect(c)
	aux.AddRitualProcGreaterCode(c,65393205)
end
