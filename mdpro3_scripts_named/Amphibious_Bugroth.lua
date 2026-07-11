--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:45
-- Source DB: cards.cdb
-- Card: Amphibious Bugroth  (ID: 40173854)
-- Type: Monster / Fusion
-- Attribute: WATER
-- Race: Aqua
-- Level: 5
-- ATK 1850 | DEF 1300
-- Scope: OCG / TCG
--
-- Effect Text:
-- "Ground Attacker Bugroth" + "Sentinel of the Seas"
--[[ __CARD_HEADER_END__ ]]

--水陸両用バグロス
function c40173854.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCode2(c,58314394,85448931,true,true)
end
