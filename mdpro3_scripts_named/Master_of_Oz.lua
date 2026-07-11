--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:44
-- Source DB: cards.cdb
-- Card: Master of Oz  (ID: 27134689)
-- Type: Monster / Fusion
-- Attribute: EARTH
-- Race: Beast
-- Level: 9
-- ATK 4200 | DEF 3700
-- Scope: OCG / TCG
--
-- Effect Text:
-- "Big Koala" + "Des Kangaroo"
--[[ __CARD_HEADER_END__ ]]

--マスター・オブ・OZ
function c27134689.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCode2(c,42129512,78613627,true,true)
end
