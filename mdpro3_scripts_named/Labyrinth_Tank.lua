--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:54
-- Source DB: cards.cdb
-- Card: Labyrinth Tank  (ID: 99551425)
-- Type: Monster / Fusion
-- Attribute: DARK
-- Race: Machine
-- Level: 7
-- ATK 2400 | DEF 2400
-- Scope: OCG / TCG
--
-- Effect Text:
-- "Giga-Tech Wolf" + "Cannon Soldier"
--[[ __CARD_HEADER_END__ ]]

--迷宮の魔戦車
function c99551425.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCode2(c,8471389,11384280,true,true)
end
