--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:44
-- Source DB: cards.cdb
-- Card: Zombie Warrior  (ID: 31339260)
-- Type: Monster / Fusion
-- Attribute: DARK
-- Race: Zombie
-- Level: 3
-- ATK 1200 | DEF 900
-- Scope: OCG / TCG
--
-- Effect Text:
-- "Skull Servant" + "Battle Warrior"
--[[ __CARD_HEADER_END__ ]]

--アンデット・ウォーリアー
function c31339260.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCode2(c,32274490,55550921,true,true)
end
