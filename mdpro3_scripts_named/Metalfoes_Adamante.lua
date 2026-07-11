--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:52
-- Source DB: cards.cdb
-- Card: Metalfoes Adamante  (ID: 81612598)
-- Type: Monster / Fusion
-- Attribute: FIRE
-- Race: Psychic
-- Level: 5
-- ATK 2500 | DEF 2500
-- Setcode: 0xe1
-- Scope: OCG / TCG
--
-- Effect Text:
-- 1 "Metalfoes" monster + 1 monster with 2500 or less ATK
--[[ __CARD_HEADER_END__ ]]

--メタルフォーゼ・アダマンテ
function c81612598.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcFun2(c,aux.FilterBoolFunction(Card.IsFusionSetCard,0xe1),aux.FilterBoolFunction(Card.IsAttackBelow,2500),true)
end
