--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:51
-- Source DB: cards.cdb
-- Card: Soul Hunter  (ID: 72869010)
-- Type: Monster / Fusion
-- Attribute: DARK
-- Race: Fiend
-- Level: 6
-- ATK 2200 | DEF 1800
-- Scope: OCG / TCG
--
-- Effect Text:
-- "Lord of the Lamp" + "Invader from Another Dimension"
--[[ __CARD_HEADER_END__ ]]

--ソウル・ハンター
function c72869010.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCode2(c,99510761,28450915,true,true)
end
