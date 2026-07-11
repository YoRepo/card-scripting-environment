--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:53
-- Source DB: cards.cdb
-- Card: Gem-Knight Zirconia  (ID: 8692301)
-- Type: Monster / Fusion
-- Attribute: EARTH
-- Race: Rock
-- Level: 8
-- ATK 2900 | DEF 2500
-- Setcode: 0x1047
-- Scope: OCG / TCG
--
-- Effect Text:
-- 1 "Gem-Knight" monster + 1 Rock monster
--[[ __CARD_HEADER_END__ ]]

--ジェムナイト・ジルコニア
function c8692301.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcFun2(c,aux.FilterBoolFunction(Card.IsFusionSetCard,0x1047),aux.FilterBoolFunction(Card.IsRace,RACE_ROCK),true)
end
