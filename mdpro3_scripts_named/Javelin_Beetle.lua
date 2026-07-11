--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:44
-- Source DB: cards.cdb
-- Card: Javelin Beetle  (ID: 26932788)
-- Type: Monster / Ritual
-- Attribute: EARTH
-- Race: Insect
-- Level: 8
-- ATK 2450 | DEF 2550
-- Scope: OCG / TCG
--
-- Effect Text:
-- This card can only be Ritual Summoned with the Ritual Spell Card, "Javelin Beetle Pact".
--[[ __CARD_HEADER_END__ ]]

--ジャベリンビートル
function c26932788.initial_effect(c)
	aux.AddCodeList(c,41182875)
	c:EnableReviveLimit()
end
