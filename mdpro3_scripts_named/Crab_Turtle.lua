--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:53
-- Source DB: cards.cdb
-- Card: Crab Turtle  (ID: 91782219)
-- Type: Monster / Ritual
-- Attribute: WATER
-- Race: Aqua
-- Level: 8
-- ATK 2550 | DEF 2500
-- Scope: OCG / TCG
--
-- Effect Text:
-- This monster can only be Ritual Summoned with the Ritual Spell Card, "Turtle Oath".
-- You must also offer monsters whose total Level Stars equal 8 or more as a Tribute from the field or
-- your hand.
--[[ __CARD_HEADER_END__ ]]

--クラブ・タートル
function c91782219.initial_effect(c)
	aux.AddCodeList(c,76806714)
	c:EnableReviveLimit()
end
