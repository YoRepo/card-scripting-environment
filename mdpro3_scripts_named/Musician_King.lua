--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:49
-- Source DB: cards.cdb
-- Card: Musician King  (ID: 56907389)
-- Type: Monster / Fusion
-- Attribute: LIGHT
-- Race: Spellcaster
-- Level: 5
-- ATK 1750 | DEF 1500
-- Scope: OCG / TCG
--
-- Effect Text:
-- "Witch of the Black Forest" + "Lady of Faith"
--[[ __CARD_HEADER_END__ ]]

--音楽家の帝王
function c56907389.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCode2(c,78010363,17358176,true,true)
end
