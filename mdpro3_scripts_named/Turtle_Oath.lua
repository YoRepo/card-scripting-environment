--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:52
-- Source DB: cards.cdb
-- Card: Turtle Oath  (ID: 76806714)
-- Type: Spell / Ritual
-- Scope: OCG / TCG
--
-- Effect Text:
-- This card is used to Ritual Summon "Crab Turtle".
-- You must also offer monsters whose total Level Stars equal 8 or more as a Tribute from the field or
-- your hand.
--[[ __CARD_HEADER_END__ ]]

--亀の誓い
function c76806714.initial_effect(c)
	aux.AddRitualProcGreaterCode(c,91782219)
end
