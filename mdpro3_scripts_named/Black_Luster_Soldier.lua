--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:30
-- Card: 混沌战士  (ID: 5405694)
-- Type: Monster / Ritual
-- Attribute: EARTH
-- Race: Warrior
-- Level 8
-- ATK 3000 | DEF 2500
-- Setcode: 4303
--
-- Effect Text:
-- 「混沌的仪式」降临。
--[[ __CARD_HEADER_END__ ]]

--カオス・ソルジャー
function c5405694.initial_effect(c)
	aux.AddCodeList(c,55761792)
	c:EnableReviveLimit()
end
