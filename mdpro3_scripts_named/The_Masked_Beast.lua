--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:47
-- Source DB: cards.cdb
-- Card: The Masked Beast  (ID: 49064413)
-- Type: Monster / Ritual
-- Attribute: DARK
-- Race: Fiend
-- Level: 8
-- ATK 3200 | DEF 1800
-- Scope: OCG / TCG
--
-- Effect Text:
-- You can Ritual Summon this card with "Curse of the Masked Beast".
--[[ __CARD_HEADER_END__ ]]

--仮面魔獣マスクド・ヘルレイザー
function c49064413.initial_effect(c)
	aux.AddCodeList(c,94377247)
	c:EnableReviveLimit()
end
