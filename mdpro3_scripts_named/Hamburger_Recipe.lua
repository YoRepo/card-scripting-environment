--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:52
-- Source DB: cards.cdb
-- Card: Hamburger Recipe  (ID: 80811661)
-- Type: Spell / Ritual
-- Setcode: 0x197
-- Scope: OCG / TCG
--
-- Effect Text:
-- This card is used to Ritual Summon "Hungry Burger".
-- You must also Tribute monsters from your hand or field whose total Levels equal 6 or more.
--[[ __CARD_HEADER_END__ ]]

--ハンバーガーのレシピ
function c80811661.initial_effect(c)
	aux.AddRitualProcGreaterCode(c,30243636)
end
