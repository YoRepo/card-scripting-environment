--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:53
-- Source DB: cards.cdb
-- Card: Contract with the Dark Master  (ID: 96420087)
-- Type: Spell / Ritual
-- Scope: OCG / TCG
--
-- Effect Text:
-- This card is used to Ritual Summon "Dark Master - Zorc".
-- You must also Tribute monsters from your hand or field whose total Levels equal 8 or more.
--[[ __CARD_HEADER_END__ ]]

--闇の支配者との契約
function c96420087.initial_effect(c)
	aux.AddRitualProcGreaterCode(c,97642679)
end
