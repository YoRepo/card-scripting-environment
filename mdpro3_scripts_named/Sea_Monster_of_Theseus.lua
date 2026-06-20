--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:37
-- Card: 忒修斯魔栖物  (ID: 96334243)
-- Type: Monster / Fusion / Tuner
-- Attribute: WATER
-- Race: Zombie
-- Level 5
-- ATK 2200 | DEF 1800
--
-- Effect Text:
-- 调整×2
--[[ __CARD_HEADER_END__ ]]

--テセウスの魔棲物
function c96334243.initial_effect(c)
	c:EnableReviveLimit()
	aux.AddFusionProcFunRep(c,aux.FilterBoolFunction(Card.IsFusionType,TYPE_TUNER),2,true)
end
