--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:47
-- Source DB: cards.cdb
-- Card: Crimson Sunbird  (ID: 46696593)
-- Type: Monster / Fusion
-- Attribute: FIRE
-- Race: Winged Beast
-- Level: 6
-- ATK 2300 | DEF 1800
-- Scope: OCG / TCG
--
-- Effect Text:
-- "Faith Bird" + "Skull Red Bird"
--[[ __CARD_HEADER_END__ ]]

--紅陽鳥
function c46696593.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCode2(c,75582395,10202894,true,true)
end
