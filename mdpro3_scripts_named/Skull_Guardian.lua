--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:26
-- Card: 法理守护者  (ID: 3627449)
-- Type: Monster / Ritual
-- Attribute: LIGHT
-- Race: Warrior
-- Level 7
-- ATK 2050 | DEF 2500
-- Setcode: 8274
--
-- Effect Text:
-- 借由「法理的祈祷」降临。必须从场上或者手札，牺牲奉献等级合计为7个以上的卡。
--[[ __CARD_HEADER_END__ ]]

--ローガーディアン
function c3627449.initial_effect(c)
	aux.AddCodeList(c,43694075)
	c:EnableReviveLimit()
end
