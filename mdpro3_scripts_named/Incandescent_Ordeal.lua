--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:44
-- Source DB: cards.cdb
-- Card: Incandescent Ordeal  (ID: 33031674)
-- Type: Spell / Ritual
-- Scope: OCG / TCG
--
-- Effect Text:
-- This card is used to Ritual Summon "Legendary Flame Lord".
-- You must also Tribute monsters whose total Levels equal 7 or more from the field or your hand.
--[[ __CARD_HEADER_END__ ]]

--灼熱の試練
function c33031674.initial_effect(c)
	aux.AddRitualProcGreaterCode(c,60258960)
end
