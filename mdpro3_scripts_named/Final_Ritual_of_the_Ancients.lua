--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:50
-- Source DB: cards.cdb
-- Card: Final Ritual of the Ancients  (ID: 60369732)
-- Type: Spell / Ritual
-- Scope: OCG / TCG
--
-- Effect Text:
-- This card is used to Ritual Summon "Reshef the Dark Being".
-- You must also Tribute monsters whose total Levels equal 8 or more from the field or your hand.
--[[ __CARD_HEADER_END__ ]]

--大邪神の儀式
function c60369732.initial_effect(c)
	aux.AddRitualProcGreaterCode(c,62420419)
end
