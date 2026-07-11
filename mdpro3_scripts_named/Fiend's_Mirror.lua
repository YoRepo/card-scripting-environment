--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:44
-- Source DB: cards.cdb
-- Card: Fiend's Mirror  (ID: 31890399)
-- Type: Monster / Ritual
-- Attribute: DARK
-- Race: Fiend
-- Level: 6
-- ATK 2100 | DEF 1800
-- Scope: OCG / TCG
--
-- Effect Text:
-- You can Ritual Summon this card with "Beastly Mirror Ritual".
--[[ __CARD_HEADER_END__ ]]

--デビルズ・ミラー
function c31890399.initial_effect(c)
	aux.AddCodeList(c,81933259)
	c:EnableReviveLimit()
end
