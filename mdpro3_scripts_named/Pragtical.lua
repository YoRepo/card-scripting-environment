--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:45
-- Source DB: cards.cdb
-- Card: Pragtical  (ID: 33691040)
-- Type: Monster / Fusion
-- Attribute: EARTH
-- Race: Dinosaur
-- Level: 5
-- ATK 1900 | DEF 1500
-- Scope: OCG / TCG
--
-- Effect Text:
-- "Trakodon" + "Flame Viper"
--[[ __CARD_HEADER_END__ ]]

--プラグティカル
function c33691040.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCode2(c,42348802,2830619,true,true)
end
