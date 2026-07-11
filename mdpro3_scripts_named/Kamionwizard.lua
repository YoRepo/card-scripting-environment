--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:45
-- Source DB: cards.cdb
-- Card: Kamionwizard  (ID: 41544074)
-- Type: Monster / Fusion
-- Attribute: DARK
-- Race: Spellcaster
-- Level: 4
-- ATK 1300 | DEF 1100
-- Setcode: 0xcf
-- Scope: OCG / TCG
--
-- Effect Text:
-- "Mystical Elf" + "Curtain of the Dark Ones"
--[[ __CARD_HEADER_END__ ]]

--カオス・ウィザード
function c41544074.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCode2(c,15025844,22026707,true,true)
end
