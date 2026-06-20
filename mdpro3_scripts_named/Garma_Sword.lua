--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: 伽玛剑  (ID: 90844184)
-- Type: Monster / Ritual
-- Attribute: DARK
-- Race: Warrior
-- Level 7
-- ATK 2550 | DEF 2150
--
-- Effect Text:
-- 「伽玛剑的誓言」降临。
--[[ __CARD_HEADER_END__ ]]

--ガルマソード
function c90844184.initial_effect(c)
	aux.AddCodeList(c,78577570)
	c:EnableReviveLimit()
end
