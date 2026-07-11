--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:47
-- Source DB: cards.cdb
-- Card: Performance of Sword  (ID: 4849037)
-- Type: Monster / Ritual
-- Attribute: EARTH
-- Race: Warrior
-- Level: 6
-- ATK 1950 | DEF 1850
-- Scope: OCG / TCG
--
-- Effect Text:
-- You can Ritual Summon this card with "Commencement Dance".
--[[ __CARD_HEADER_END__ ]]

--ダンシング・ソルジャー
function c4849037.initial_effect(c)
	aux.AddCodeList(c,43417563)
	c:EnableReviveLimit()
end
