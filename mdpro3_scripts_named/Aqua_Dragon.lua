--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:52
-- Source DB: cards.cdb
-- Card: Aqua Dragon  (ID: 86164529)
-- Type: Monster / Fusion
-- Attribute: WATER
-- Race: Sea Serpent
-- Level: 6
-- ATK 2250 | DEF 1900
-- Scope: OCG / TCG
--
-- Effect Text:
-- "Fairy Dragon" + "Amazon of the Seas" + "Zone Eater"
--[[ __CARD_HEADER_END__ ]]

--アクア・ドラゴン
function c86164529.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCode3(c,20315854,17968114,86100785,true,true)
end
