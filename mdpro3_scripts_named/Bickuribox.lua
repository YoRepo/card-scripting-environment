--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:44
-- Source DB: cards.cdb
-- Card: Bickuribox  (ID: 25655502)
-- Type: Monster / Fusion
-- Attribute: DARK
-- Race: Fiend
-- Level: 7
-- ATK 2300 | DEF 2000
-- Scope: OCG / TCG
--
-- Effect Text:
-- "Crass Clown" + "Dream Clown"
--[[ __CARD_HEADER_END__ ]]

--デビル・ボックス
function c25655502.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCode2(c,93889755,13215230,true,true)
end
