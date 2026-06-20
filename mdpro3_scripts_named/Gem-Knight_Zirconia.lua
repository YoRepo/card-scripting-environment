--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: 宝石骑士·仿钻  (ID: 8692301)
-- Type: Monster / Fusion
-- Attribute: EARTH
-- Race: Rock
-- Level 8
-- ATK 2900 | DEF 2500
-- Setcode: 4167
--
-- Effect Text:
-- 「宝石骑士」怪兽＋岩石族怪兽
--[[ __CARD_HEADER_END__ ]]

--ジェムナイト・ジルコニア
function c8692301.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcFun2(c,aux.FilterBoolFunction(Card.IsFusionSetCard,0x1047),aux.FilterBoolFunction(Card.IsRace,RACE_ROCK),true)
end
