--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:54
-- Source DB: cards.cdb
-- Card: Dokurorider  (ID: 99721536)
-- Type: Monster / Ritual
-- Attribute: DARK
-- Race: Zombie
-- Level: 6
-- ATK 1900 | DEF 1850
-- Scope: OCG / TCG
--
-- Effect Text:
-- You can Ritual Summon this card with "Revival of Dokurorider".
--[[ __CARD_HEADER_END__ ]]

--スカルライダー
function c99721536.initial_effect(c)
	aux.AddCodeList(c,31066283)
	c:EnableReviveLimit()
end
