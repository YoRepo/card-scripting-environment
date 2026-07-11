--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:44
-- Source DB: cards.cdb
-- Card: Blue-Eyes Ultimate Dragon  (ID: 23995346)
-- Type: Monster / Fusion
-- Attribute: LIGHT
-- Race: Dragon
-- Level: 12
-- ATK 4500 | DEF 3800
-- Setcode: 0xdd
-- Scope: OCG / TCG
--
-- Effect Text:
-- "Blue-Eyes White Dragon" + "Blue-Eyes White Dragon" + "Blue-Eyes White Dragon"
--[[ __CARD_HEADER_END__ ]]

--青眼の究極竜
function c23995346.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCodeRep(c,89631139,3,true,true)
end
