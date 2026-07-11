--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:44
-- Source DB: cards.cdb
-- Card: Hungry Burger  (ID: 30243636)
-- Type: Monster / Ritual
-- Attribute: DARK
-- Race: Warrior
-- Level: 6
-- ATK 2000 | DEF 1850
-- Scope: OCG / TCG
--
-- Effect Text:
-- You can Ritual Summon this card with "Hamburger Recipe".
--[[ __CARD_HEADER_END__ ]]

--ハングリーバーガー
function c30243636.initial_effect(c)
	aux.AddCodeList(c,80811661)
	c:EnableReviveLimit()
end
