--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:44
-- Source DB: cards.cdb
-- Card: Deepsea Shark  (ID: 28593363)
-- Type: Monster / Fusion
-- Attribute: WATER
-- Race: Fish
-- Level: 5
-- ATK 1900 | DEF 1600
-- Scope: OCG / TCG
--
-- Effect Text:
-- "Bottom Dweller" + "Tongyo"
--[[ __CARD_HEADER_END__ ]]

--深海に潜むサメ
function c28593363.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCode2(c,81386177,69572024,true,true)
end
