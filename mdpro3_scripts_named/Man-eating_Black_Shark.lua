--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:52
-- Source DB: cards.cdb
-- Card: Man-eating Black Shark  (ID: 80727036)
-- Type: Monster / Fusion
-- Attribute: WATER
-- Race: Fish
-- Level: 5
-- ATK 2100 | DEF 1300
-- Scope: OCG / TCG
--
-- Effect Text:
-- "Sea Kamen" + "Gruesome Goo" + "Amazon of the Seas"
--[[ __CARD_HEADER_END__ ]]

--黒き人食い鮫
function c80727036.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCode3(c,71746462,65623423,17968114,true,true)
end
