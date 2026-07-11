--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:52
-- Source DB: cards.cdb
-- Card: Rare Fish  (ID: 80516007)
-- Type: Monster / Fusion
-- Attribute: WATER
-- Race: Fish
-- Level: 4
-- ATK 1500 | DEF 1200
-- Scope: OCG / TCG
--
-- Effect Text:
-- "Fusionist" + "Enchanting Mermaid"
--[[ __CARD_HEADER_END__ ]]

--レア・フィッシュ
function c80516007.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCode2(c,1641882,75376965,true,true)
end
