--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:44
-- Source DB: cards.cdb
-- Card: Mystical Sand  (ID: 32751480)
-- Type: Monster / Fusion
-- Attribute: EARTH
-- Race: Rock
-- Level: 6
-- ATK 2100 | DEF 1700
-- Scope: OCG / TCG
--
-- Effect Text:
-- "Giant Soldier of Stone" + "Ancient Elf"
--[[ __CARD_HEADER_END__ ]]

--砂の魔女
function c32751480.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCode2(c,13039848,93221206,true,true)
end
