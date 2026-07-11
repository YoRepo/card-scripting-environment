--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:54
-- Source DB: cards.cdb
-- Card: Emblem of the Awakening  (ID: 9845733)
-- Type: Spell / Ritual
-- Scope: OCG / TCG
--
-- Effect Text:
-- This card is used to Ritual Summon "Cú Chulainn the Awakened".
-- You must also Tribute monsters whose total Levels equal 4 or more from the field or your hand.
--[[ __CARD_HEADER_END__ ]]

--覚醒の証
function c9845733.initial_effect(c)
	aux.AddRitualProcGreaterCode(c,10789972)
end
