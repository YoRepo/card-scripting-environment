--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:44
-- Source DB: cards.cdb
-- Card: Rose Spectre of Dunn  (ID: 32485271)
-- Type: Monster / Fusion
-- Attribute: DARK
-- Race: Plant
-- Level: 6
-- ATK 2000 | DEF 1800
-- Scope: OCG / TCG
--
-- Effect Text:
-- "Feral Imp" + "Snakeyashi"
--[[ __CARD_HEADER_END__ ]]

--バラに棲む悪霊
function c32485271.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCode2(c,41392891,29802344,true,true)
end
