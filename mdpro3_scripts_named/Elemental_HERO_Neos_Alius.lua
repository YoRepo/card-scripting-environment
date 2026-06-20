--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 元素英雄 次新宇侠  (ID: 69884162)
-- Type: Monster / Effect / Gemini
-- Attribute: LIGHT
-- Race: Warrior
-- Level 4
-- ATK 1900 | DEF 1300
-- Setcode: 602120
--
-- Effect Text:
-- ①：这张卡只要在场上·墓地存在，当作通常怪兽使用。
-- ②：可以把场上的当作通常怪兽使用的这张卡作为通常召唤作再1次召唤。那个场合这张卡变成当作效果怪兽使用并得到以下效果。
-- ●这张卡只要在怪兽区域存在，卡名当作「元素英雄 新宇侠」使用。
--[[ __CARD_HEADER_END__ ]]

--E・HERO アナザー・ネオス
function c69884162.initial_effect(c)
	aux.EnableDualAttribute(c)
	--code
	aux.EnableChangeCode(c,89943723,LOCATION_MZONE,aux.IsDualState)
end
