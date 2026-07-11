--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:53
-- Source DB: cards.cdb
-- Card: Sea Monster of Theseus  (ID: 96334243)
-- Type: Monster / Fusion / Tuner
-- Attribute: WATER
-- Race: Zombie
-- Level: 5
-- ATK 2200 | DEF 1800
-- Scope: OCG / TCG
--
-- Effect Text:
-- 2 Tuners
--[[ __CARD_HEADER_END__ ]]

--テセウスの魔棲物
function c96334243.initial_effect(c)
	c:EnableReviveLimit()
	aux.AddFusionProcFunRep(c,aux.FilterBoolFunction(Card.IsFusionType,TYPE_TUNER),2,true)
end
