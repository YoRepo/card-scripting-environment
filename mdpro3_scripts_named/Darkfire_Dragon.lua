--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:43
-- Source DB: cards.cdb
-- Card: Darkfire Dragon  (ID: 17881964)
-- Type: Monster / Fusion
-- Attribute: DARK
-- Race: Dragon
-- Level: 4
-- ATK 1500 | DEF 1250
-- Scope: OCG / TCG
--
-- Effect Text:
-- "Firegrass" + "Petit Dragon"
--[[ __CARD_HEADER_END__ ]]

--暗黒火炎龍
function c17881964.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCode2(c,53293545,75356564,true,true)
end
