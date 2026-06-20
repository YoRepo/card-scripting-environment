--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:26
-- Card: 砂之魔女  (ID: 32751480)
-- Type: Monster / Fusion
-- Attribute: EARTH
-- Race: Rock
-- Level 6
-- ATK 2100 | DEF 1700
--
-- Effect Text:
-- 「岩石巨兵」＋「古代精灵」
--[[ __CARD_HEADER_END__ ]]

--砂の魔女
function c32751480.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCode2(c,13039848,93221206,true,true)
end
