--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:53
-- Source DB: cards.cdb
-- Card: Kaminari Attack  (ID: 9653271)
-- Type: Monster / Fusion
-- Attribute: WIND
-- Race: Thunder
-- Level: 5
-- ATK 1900 | DEF 1400
-- Scope: OCG / TCG
--
-- Effect Text:
-- "Ocubeam" + "Mega Thunderball"
--[[ __CARD_HEADER_END__ ]]

--雷神の怒り
function c9653271.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCode2(c,86088138,21817254,true,true)
end
