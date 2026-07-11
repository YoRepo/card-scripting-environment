--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:52
-- Source DB: cards.cdb
-- Card: Zera Ritual  (ID: 81756897)
-- Type: Spell / Ritual
-- Scope: OCG / TCG
--
-- Effect Text:
-- This card is used to Ritual Summon "Zera the Mant".
-- You must also Tribute monsters from your hand or field whose total Levels equal 8 or more.
--[[ __CARD_HEADER_END__ ]]

--ゼラの儀式
function c81756897.initial_effect(c)
	aux.AddRitualProcGreaterCode(c,69123138)
end
