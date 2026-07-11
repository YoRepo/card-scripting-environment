--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:43
-- Source DB: cards.cdb
-- Card: Fusionist  (ID: 1641882)
-- Type: Monster / Fusion
-- Attribute: EARTH
-- Race: Beast
-- Level: 3
-- ATK 900 | DEF 700
-- Scope: OCG / TCG
--
-- Effect Text:
-- "Petit Angel" + "Mystical Sheep #2"
--[[ __CARD_HEADER_END__ ]]

--フュージョニスト
function c1641882.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCode2(c,38142739,83464209,true,true)
end
