--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:45
-- Source DB: cards.cdb
-- Card: Black Illusion Ritual  (ID: 41426869)
-- Type: Spell / Ritual
-- Scope: OCG / TCG
--
-- Effect Text:
-- This card is used to Ritual Summon "Relinquished".
-- You must also Tribute a monster from your hand or field whose Level is 1 or more.
--[[ __CARD_HEADER_END__ ]]

--イリュージョンの儀式
function c41426869.initial_effect(c)
	aux.AddRitualProcGreaterCode(c,64631466)
end
