--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:53
-- Source DB: cards.cdb
-- Card: Kaiser Dragon  (ID: 94566432)
-- Type: Monster / Fusion
-- Attribute: LIGHT
-- Race: Dragon
-- Level: 7
-- ATK 2300 | DEF 2000
-- Scope: OCG / TCG
--
-- Effect Text:
-- "Winged Dragon, Guardian of the Fortress #1" + "Fairy Dragon"
--[[ __CARD_HEADER_END__ ]]

--カイザー・ドラゴン
function c94566432.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCode2(c,87796900,20315854,true,true)
end
