--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:52
-- Source DB: cards.cdb
-- Card: Garma Sword Oath  (ID: 78577570)
-- Type: Spell / Ritual
-- Scope: OCG / TCG
--
-- Effect Text:
-- This card is used to Ritual Summon "Garma Sword".
-- You must also Tribute monsters whose total Levels equal 7 or more from the field or your hand.
--[[ __CARD_HEADER_END__ ]]

--ガルマソードの誓い
function c78577570.initial_effect(c)
	aux.AddRitualProcGreaterCode(c,90844184)
end
