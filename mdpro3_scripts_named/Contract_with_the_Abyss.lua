--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:51
-- Source DB: cards.cdb
-- Card: Contract with the Abyss  (ID: 69035382)
-- Type: Spell / Ritual
-- Scope: OCG / TCG
--
-- Effect Text:
-- This card can be used to Ritual Summon any DARK Ritual Monster.
-- You must also Tribute monsters from your hand or field whose total Levels exactly equal the Level of
-- the Ritual Monster you Ritual Summon.
--[[ __CARD_HEADER_END__ ]]

--奈落との契約
function c69035382.initial_effect(c)
	aux.AddRitualProcEqual2(c,c69035382.ritual_filter)
end
function c69035382.ritual_filter(c)
	return c:IsType(TYPE_RITUAL) and c:IsAttribute(ATTRIBUTE_DARK)
end
