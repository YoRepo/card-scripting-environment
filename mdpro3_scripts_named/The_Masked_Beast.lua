--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: 假面魔兽 鬼面修道士  (ID: 49064413)
-- Type: Monster / Ritual
-- Attribute: DARK
-- Race: Fiend
-- Level 8
-- ATK 3200 | DEF 1800
--
-- Effect Text:
-- 「假面魔兽的仪式」降临。
--[[ __CARD_HEADER_END__ ]]

--仮面魔獣マスクド・ヘルレイザー
function c49064413.initial_effect(c)
	aux.AddCodeList(c,94377247)
	c:EnableReviveLimit()
end
