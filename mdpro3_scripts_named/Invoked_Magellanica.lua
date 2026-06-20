--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: 召唤兽 墨瓦腊泥加  (ID: 48791583)
-- Type: Monster / Fusion
-- Attribute: EARTH
-- Race: Rock
-- Level 8
-- ATK 3000 | DEF 3300
-- Setcode: 244
--
-- Effect Text:
-- 「召唤师 阿莱斯特」＋地属性怪兽
--[[ __CARD_HEADER_END__ ]]

--召喚獣メガラニカ
function c48791583.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCodeFun(c,86120751,aux.FilterBoolFunction(Card.IsFusionAttribute,ATTRIBUTE_EARTH),1,true,true)
end
