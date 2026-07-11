--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:51
-- Source DB: cards.cdb
-- Card: Shinobird's Calling  (ID: 73055622)
-- Type: Spell / Ritual
-- Scope: OCG / TCG
--
-- Effect Text:
-- This card is used to Ritual Summon "Shinobaroness Peacock" or "Shinobaron Peacock".
-- You must also Tribute monsters from your hand or field and/or banish Spirit monsters from your GY,
-- whose total Levels equal or exceed the Level of the Ritual Monster you Ritual Summon.
--[[ __CARD_HEADER_END__ ]]

--霊魂の降神
function c73055622.initial_effect(c)
	aux.AddRitualProcGreater2Code2(c,25415052,52900000,nil,c73055622.mfilter)
end
c73055622.has_text_type=TYPE_SPIRIT
function c73055622.mfilter(c)
	return c:IsType(TYPE_SPIRIT)
end
