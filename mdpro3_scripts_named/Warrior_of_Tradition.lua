--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:49
-- Source DB: cards.cdb
-- Card: Warrior of Tradition  (ID: 56413937)
-- Type: Monster / Fusion
-- Attribute: EARTH
-- Race: Warrior
-- Level: 6
-- ATK 1900 | DEF 1700
-- Scope: OCG / TCG
--
-- Effect Text:
-- "Sonic Maid" + "Beautiful Headhuntress"
--[[ __CARD_HEADER_END__ ]]

--戦場の死装束
function c56413937.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCode2(c,38942059,16899564,true,true)
end
