--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:46
-- Source DB: cards.cdb
-- Card: Novox's Prayer  (ID: 43694075)
-- Type: Spell / Ritual
-- Scope: OCG / TCG
--
-- Effect Text:
-- This card is used to Ritual Summon "Skull Guardian".
-- You must also Tribute monsters from your hand or field whose total Levels equal 7 or more.
--[[ __CARD_HEADER_END__ ]]

--ローの祈り
function c43694075.initial_effect(c)
	aux.AddRitualProcGreaterCode(c,3627449)
end
