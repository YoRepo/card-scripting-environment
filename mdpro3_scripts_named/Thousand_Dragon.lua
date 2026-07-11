--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:45
-- Source DB: cards.cdb
-- Card: Thousand Dragon  (ID: 41462083)
-- Type: Monster / Fusion
-- Attribute: WIND
-- Race: Dragon
-- Level: 7
-- ATK 2400 | DEF 2000
-- Scope: OCG / TCG
--
-- Effect Text:
-- "Time Wizard" + "Baby Dragon"
--[[ __CARD_HEADER_END__ ]]

--千年竜
function c41462083.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCode2(c,71625222,88819587,true,true)
end
