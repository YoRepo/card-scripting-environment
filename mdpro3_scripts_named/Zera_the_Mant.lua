--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:51
-- Source DB: cards.cdb
-- Card: Zera the Mant  (ID: 69123138)
-- Type: Monster / Ritual
-- Attribute: DARK
-- Race: Fiend
-- Level: 8
-- ATK 2800 | DEF 2300
-- Scope: OCG / TCG
--
-- Effect Text:
-- You can Ritual Summon this card with "Zera Ritual".
--[[ __CARD_HEADER_END__ ]]

--ゼラ
function c69123138.initial_effect(c)
	aux.AddCodeList(c,81756897)
	c:EnableReviveLimit()
end
