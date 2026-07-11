--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:53
-- Source DB: cards.cdb
-- Card: Curse of the Masked Beast  (ID: 94377247)
-- Type: Spell / Ritual
-- Scope: OCG / TCG
--
-- Effect Text:
-- This card is used to Ritual Summon "The Masked Beast".
-- You must also Tribute monsters from your hand or field whose total Levels equal 8 or more.
--[[ __CARD_HEADER_END__ ]]

--仮面魔獣の儀式
function c94377247.initial_effect(c)
	aux.AddRitualProcGreaterCode(c,49064413)
end
