--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 死亡鸟  (ID: 8327462)
-- Type: Monster / Fusion
-- Attribute: WIND
-- Race: Winged Beast
-- Level 6
-- ATK 1900 | DEF 1700
--
-- Effect Text:
-- 「橐蜚」＋「骷髅寺院」
--[[ __CARD_HEADER_END__ ]]

--デス・バード
function c8327462.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCode2(c,3170832,732302,true,true)
end
