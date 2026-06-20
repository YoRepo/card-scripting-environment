--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: 水精龙  (ID: 86164529)
-- Type: Monster / Fusion
-- Attribute: WATER
-- Race: Sea Serpent
-- Level 6
-- ATK 2250 | DEF 1900
--
-- Effect Text:
-- 「妖精龙」＋「海原的女战士」＋「区域吞噬者」
--[[ __CARD_HEADER_END__ ]]

--アクア・ドラゴン
function c86164529.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCode3(c,20315854,17968114,86100785,true,true)
end
