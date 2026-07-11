--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:43
-- Source DB: cards.cdb
-- Card: Roaring Ocean Snake  (ID: 19066538)
-- Type: Monster / Fusion
-- Attribute: WATER
-- Race: Aqua
-- Level: 6
-- ATK 2100 | DEF 1800
-- Scope: OCG / TCG
--
-- Effect Text:
-- "Mystic Lamp" + "Hyosube"
--[[ __CARD_HEADER_END__ ]]

--轟きの大海蛇
function c19066538.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCode2(c,98049915,2118022,true,true)
end
