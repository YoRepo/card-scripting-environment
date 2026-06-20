--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 饥饿的汉堡  (ID: 30243636)
-- Type: Monster / Ritual
-- Attribute: DARK
-- Race: Warrior
-- Level 6
-- ATK 2000 | DEF 1850
--
-- Effect Text:
-- 「汉堡的食谱」降临
--[[ __CARD_HEADER_END__ ]]

--ハングリーバーガー
function c30243636.initial_effect(c)
	aux.AddCodeList(c,80811661)
	c:EnableReviveLimit()
end
