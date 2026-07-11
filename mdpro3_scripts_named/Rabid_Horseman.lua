--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:53
-- Source DB: cards.cdb
-- Card: Rabid Horseman  (ID: 94905343)
-- Type: Monster / Fusion
-- Attribute: EARTH
-- Race: Beast-Warrior
-- Level: 6
-- ATK 2000 | DEF 1700
-- Scope: OCG / TCG
--
-- Effect Text:
-- "Battle Ox" + "Mystic Horseman"
--[[ __CARD_HEADER_END__ ]]

--ミノケンタウロス
function c94905343.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCode2(c,5053103,68516705,true,true)
end
