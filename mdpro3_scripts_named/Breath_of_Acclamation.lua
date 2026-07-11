--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:46
-- Source DB: cards.cdb
-- Card: Breath of Acclamation  (ID: 44221928)
-- Type: Spell / Ritual
-- Scope: OCG / TCG
--
-- Effect Text:
-- This card can be used to Ritual Summon any WIND Ritual Monster.
-- You must also Tribute monsters from your hand or field whose total Levels exactly equal the Level of
-- the Ritual Monster you Ritual Summon.
--[[ __CARD_HEADER_END__ ]]

--褒誉の息吹
function c44221928.initial_effect(c)
	aux.AddRitualProcEqual2(c,c44221928.ritual_filter)
end
function c44221928.ritual_filter(c)
	return c:IsType(TYPE_RITUAL) and c:IsAttribute(ATTRIBUTE_WIND)
end
