--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 杰拉  (ID: 69123138)
-- Type: Monster / Ritual
-- Attribute: DARK
-- Race: Fiend
-- Level 8
-- ATK 2800 | DEF 2300
--
-- Effect Text:
-- 「杰拉的仪式」降临。
--[[ __CARD_HEADER_END__ ]]

--ゼラ
function c69123138.initial_effect(c)
	aux.AddCodeList(c,81756897)
	c:EnableReviveLimit()
end
