--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:51
-- Source DB: cards.cdb
-- Card: Barox  (ID: 6840573)
-- Type: Monster / Fusion
-- Attribute: DARK
-- Race: Fiend
-- Level: 5
-- ATK 1380 | DEF 1530
-- Scope: OCG / TCG
--
-- Effect Text:
-- "Frenzied Panda" + "Ryu-Kishin"
--[[ __CARD_HEADER_END__ ]]

--バロックス
function c6840573.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCode2(c,98818516,15303296,true,true)
end
