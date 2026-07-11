--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:51
-- Source DB: cards.cdb
-- Card: Synthesis Spell  (ID: 72446038)
-- Type: Spell / Ritual
-- Scope: OCG / TCG
--
-- Effect Text:
-- This card is used to Ritual Summon "Lycanthrope".
-- You must also Tribute monsters whose total Levels equal 6 or more from the field or your hand.
--[[ __CARD_HEADER_END__ ]]

--合成魔術
function c72446038.initial_effect(c)
	aux.AddRitualProcGreaterCode(c,84385264)
end
