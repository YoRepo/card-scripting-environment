--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:52
-- Source DB: cards.cdb
-- Card: End of the World  (ID: 8198712)
-- Type: Spell / Ritual
-- Setcode: 0x1da
-- Scope: OCG / TCG
--
-- Effect Text:
-- This card is used to Ritual Summon "Ruin, Queen of Oblivion" or "Demise, King of Armageddon".
-- You must also Tribute monsters from your hand or field whose total Levels exactly equal the Level of
-- the Ritual Monster you Ritual Summon.
--[[ __CARD_HEADER_END__ ]]

--エンド・オブ・ザ・ワールド
function c8198712.initial_effect(c)
	aux.AddRitualProcEqual2Code2(c,72426662,46427957)
end
