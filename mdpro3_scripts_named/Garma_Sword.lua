--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:53
-- Source DB: cards.cdb
-- Card: Garma Sword  (ID: 90844184)
-- Type: Monster / Ritual
-- Attribute: DARK
-- Race: Warrior
-- Level: 7
-- ATK 2550 | DEF 2150
-- Scope: OCG / TCG
--
-- Effect Text:
-- This monster can only be Ritual Summoned with the Ritual Spell Card, "Garma Sword Oath".
--[[ __CARD_HEADER_END__ ]]

--ガルマソード
function c90844184.initial_effect(c)
	aux.AddCodeList(c,78577570)
	c:EnableReviveLimit()
end
