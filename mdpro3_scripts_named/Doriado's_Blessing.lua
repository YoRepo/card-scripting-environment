--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:44
-- Source DB: cards.cdb
-- Card: Doriado's Blessing  (ID: 23965037)
-- Type: Spell / Ritual
-- Scope: OCG / TCG
--
-- Effect Text:
-- This card is used to Ritual Summon "Elemental Mistress Doriado".
-- You must also Tribute monsters whose total Levels equal 3 or more from the field or your hand.
--[[ __CARD_HEADER_END__ ]]

--ドリアードの祈り
function c23965037.initial_effect(c)
	aux.AddRitualProcGreaterCode(c,99414168)
end
