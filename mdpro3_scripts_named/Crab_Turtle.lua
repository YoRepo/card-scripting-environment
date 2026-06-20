--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:36
-- Card: 蟹龟  (ID: 91782219)
-- Type: Monster / Ritual
-- Attribute: WATER
-- Race: Aqua
-- Level 8
-- ATK 2550 | DEF 2500
--
-- Effect Text:
-- 「龟的誓言」降临。必须从场地和手卡把等级直到8以上的卡作为祭品。
--[[ __CARD_HEADER_END__ ]]

--クラブ・タートル
function c91782219.initial_effect(c)
	aux.AddCodeList(c,76806714)
	c:EnableReviveLimit()
end
