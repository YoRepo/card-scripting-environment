--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:49
-- Source DB: cards.cdb
-- Card: Great Mammoth of Goldfine  (ID: 54622031)
-- Type: Monster / Fusion
-- Attribute: DARK
-- Race: Zombie
-- Level: 6
-- ATK 2200 | DEF 1800
-- Scope: OCG / TCG
--
-- Effect Text:
-- "The Snake Hair" + "Dragon Zombie"
--[[ __CARD_HEADER_END__ ]]

--金色の魔象
function c54622031.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCode2(c,29491031,66672569,true,true)
end
