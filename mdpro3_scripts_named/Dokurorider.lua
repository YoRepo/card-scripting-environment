--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:37
-- Card: 骷髅骑手  (ID: 99721536)
-- Type: Monster / Ritual
-- Attribute: DARK
-- Race: Zombie
-- Level 6
-- ATK 1900 | DEF 1850
--
-- Effect Text:
-- 使用「骷髅骑手的复活」特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--スカルライダー
function c99721536.initial_effect(c)
	aux.AddCodeList(c,31066283)
	c:EnableReviveLimit()
end
