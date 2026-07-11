--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:45
-- Source DB: cards.cdb
-- Card: Javelin Beetle Pact  (ID: 41182875)
-- Type: Spell / Ritual
-- Scope: OCG / TCG
--
-- Effect Text:
-- This card is used to Ritual Summon "Javelin Beetle".
-- You must also Tribute monsters from the field or your hand whose total Levels equal 8 or more.
--[[ __CARD_HEADER_END__ ]]

--ジャベリンビートルの契約
function c41182875.initial_effect(c)
	aux.AddRitualProcGreaterCode(c,26932788)
end
