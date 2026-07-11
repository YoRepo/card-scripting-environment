--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:44
-- Source DB: cards.cdb
-- Card: Marine Beast  (ID: 29929832)
-- Type: Monster / Fusion
-- Attribute: WATER
-- Race: Fish
-- Level: 5
-- ATK 1700 | DEF 1600
-- Scope: OCG / TCG
--
-- Effect Text:
-- "Water Magician" + "Behegon"
--[[ __CARD_HEADER_END__ ]]

--マリン・ビースト
function c29929832.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCode2(c,93343894,94022093,true,true)
end
