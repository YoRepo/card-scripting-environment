--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:49
-- Source DB: cards.cdb
-- Card: Twin-Headed Thunder Dragon  (ID: 54752875)
-- Type: Monster / Fusion
-- Attribute: LIGHT
-- Race: Thunder
-- Level: 7
-- ATK 2800 | DEF 2100
-- Setcode: 0x11c
-- Scope: OCG / TCG
--
-- Effect Text:
-- "Thunder Dragon" + "Thunder Dragon"
--[[ __CARD_HEADER_END__ ]]

--双頭の雷龍
function c54752875.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCodeRep(c,31786629,2,true,true)
end
