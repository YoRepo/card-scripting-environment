--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:46
-- Source DB: cards.cdb
-- Card: Flame Swordsman  (ID: 45231177)
-- Type: Monster / Fusion
-- Attribute: FIRE
-- Race: Warrior
-- Level: 5
-- ATK 1800 | DEF 1600
-- Scope: OCG / TCG
--
-- Effect Text:
-- "Flame Manipulator" + "Masaki the Legendary Swordsman"
--[[ __CARD_HEADER_END__ ]]

--炎の剣士
function c45231177.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCode2(c,34460851,44287299,true,true)
end
