--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:46
-- Source DB: cards.cdb
-- Card: Commencement Dance  (ID: 43417563)
-- Type: Spell / Ritual
-- Scope: OCG / TCG
--
-- Effect Text:
-- This card is used to Ritual Summon "Performance of Sword".
-- You must also Tribute monsters from your hand or field whose total Levels equal 6 or more.
--[[ __CARD_HEADER_END__ ]]

--踊りによる誘発
function c43417563.initial_effect(c)
	aux.AddRitualProcGreaterCode(c,4849037)
end
