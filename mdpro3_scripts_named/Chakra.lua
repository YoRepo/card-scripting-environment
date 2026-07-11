--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:50
-- Source DB: cards.cdb
-- Card: Chakra  (ID: 65393205)
-- Type: Monster / Ritual
-- Attribute: DARK
-- Race: Fiend
-- Level: 7
-- ATK 2450 | DEF 2000
-- Scope: OCG / TCG
--
-- Effect Text:
-- You can Ritual Summon this card with "Resurrection of Chakra".
--[[ __CARD_HEADER_END__ ]]

--チャクラ
function c65393205.initial_effect(c)
	aux.AddCodeList(c,39399168)
	c:EnableReviveLimit()
end
