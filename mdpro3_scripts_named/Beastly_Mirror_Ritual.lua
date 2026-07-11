--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:52
-- Source DB: cards.cdb
-- Card: Beastly Mirror Ritual  (ID: 81933259)
-- Type: Spell / Ritual
-- Scope: OCG / TCG
--
-- Effect Text:
-- This card is used to Ritual Summon "Fiend's Mirror".
-- You must also Tribute monsters from the field or your hand whose total Levels equal 6 or more.
--[[ __CARD_HEADER_END__ ]]

--悪魔鏡の儀式
function c81933259.initial_effect(c)
	aux.AddRitualProcGreaterCode(c,31890399)
end
