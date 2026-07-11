--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:50
-- Source DB: cards.cdb
-- Card: Shinato's Ark  (ID: 60365591)
-- Type: Spell / Ritual
-- Scope: OCG / TCG
--
-- Effect Text:
-- This card is used to Ritual Summon "Shinato, King of a Higher Plane".
-- You must also Tribute monsters from your hand or field whose total Levels equal 8 or more.
--[[ __CARD_HEADER_END__ ]]

--奇跡の方舟
function c60365591.initial_effect(c)
	aux.AddRitualProcGreaterCode(c,86327225)
end
