--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 墙壁之影  (ID: 63162310)
-- Type: Monster / Effect / SpecialSummon
-- Attribute: DARK
-- Race: Warrior
-- Level 7
-- ATK 1600 | DEF 3000
--
-- Effect Text:
-- 不用「迷宫变化」的效果不能特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--ウォール・シャドウ
function c63162310.initial_effect(c)
	c:EnableReviveLimit()
end
