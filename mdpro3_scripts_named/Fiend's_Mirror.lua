--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:26
-- Card: 恶魔镜  (ID: 31890399)
-- Type: Monster / Ritual
-- Attribute: DARK
-- Race: Fiend
-- Level 6
-- ATK 2100 | DEF 1800
--
-- Effect Text:
-- 「恶魔镜的仪式」降临。
--[[ __CARD_HEADER_END__ ]]

--デビルズ・ミラー
function c31890399.initial_effect(c)
	aux.AddCodeList(c,81933259)
	c:EnableReviveLimit()
end
