--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:53
-- Source DB: cards.cdb
-- Card: Flower Wolf  (ID: 95952802)
-- Type: Monster / Fusion
-- Attribute: EARTH
-- Race: Beast
-- Level: 5
-- ATK 1800 | DEF 1400
-- Scope: OCG / TCG
--
-- Effect Text:
-- "Silver Fang" + "Darkworld Thorns"
--[[ __CARD_HEADER_END__ ]]

--フラワー・ウルフ
function c95952802.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCode2(c,90357090,43500484,true,true)
end
