--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:44
-- Source DB: cards.cdb
-- Card: Skelgon  (ID: 32355828)
-- Type: Monster / Fusion
-- Attribute: DARK
-- Race: Zombie
-- Level: 6
-- ATK 1700 | DEF 1900
-- Scope: OCG / TCG
--
-- Effect Text:
-- "The Snake Hair" + "Blackland Fire Dragon"
--[[ __CARD_HEADER_END__ ]]

--スケルゴン
function c32355828.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCode2(c,29491031,87564352,true,true)
end
