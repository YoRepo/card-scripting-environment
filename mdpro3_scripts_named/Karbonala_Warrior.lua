--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:49
-- Source DB: cards.cdb
-- Card: Karbonala Warrior  (ID: 54541900)
-- Type: Monster / Fusion
-- Attribute: EARTH
-- Race: Warrior
-- Level: 4
-- ATK 1500 | DEF 1200
-- Scope: OCG / TCG
--
-- Effect Text:
-- "M-Warrior #1" + "M-Warrior #2"
--[[ __CARD_HEADER_END__ ]]

--カルボナーラ戦士
function c54541900.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCode2(c,56342351,92731455,true,true)
end
