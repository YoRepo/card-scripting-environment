--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:47
-- Source DB: cards.cdb
-- Card: Invoked Magellanica  (ID: 48791583)
-- Type: Monster / Fusion
-- Attribute: EARTH
-- Race: Rock
-- Level: 8
-- ATK 3000 | DEF 3300
-- Setcode: 0xf4
-- Scope: OCG / TCG
--
-- Effect Text:
-- "Aleister the Invoker" + 1 EARTH monster
--[[ __CARD_HEADER_END__ ]]

--召喚獣メガラニカ
function c48791583.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCodeFun(c,86120751,aux.FilterBoolFunction(Card.IsFusionAttribute,ATTRIBUTE_EARTH),1,true,true)
end
