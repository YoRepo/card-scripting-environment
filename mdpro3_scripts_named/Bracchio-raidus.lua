--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:43
-- Source DB: cards.cdb
-- Card: Bracchio-raidus  (ID: 16507828)
-- Type: Monster / Fusion
-- Attribute: WATER
-- Race: Dinosaur
-- Level: 6
-- ATK 2200 | DEF 2000
-- Scope: OCG / TCG
--
-- Effect Text:
-- "Two-Headed King Rex" + "Crawling Dragon #2"
--[[ __CARD_HEADER_END__ ]]

--ブラキオレイドス
function c16507828.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCode2(c,94119974,38289717,true,true)
end
