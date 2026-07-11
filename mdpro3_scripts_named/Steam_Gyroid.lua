--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:49
-- Source DB: cards.cdb
-- Card: Steam Gyroid  (ID: 5368615)
-- Type: Monster / Fusion
-- Attribute: EARTH
-- Race: Machine
-- Level: 6
-- ATK 2200 | DEF 1600
-- Setcode: 0x16
-- Scope: OCG / TCG
--
-- Effect Text:
-- "Gyroid" + "Steamroid"
--[[ __CARD_HEADER_END__ ]]

--スチームジャイロイド
function c5368615.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCode2(c,18325492,44729197,true,true)
end
