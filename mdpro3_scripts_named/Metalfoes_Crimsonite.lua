--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:49
-- Source DB: cards.cdb
-- Card: Metalfoes Crimsonite  (ID: 54401832)
-- Type: Monster / Fusion
-- Attribute: FIRE
-- Race: Psychic
-- Level: 9
-- ATK 3000 | DEF 3000
-- Setcode: 0xe1
-- Scope: OCG / TCG
--
-- Effect Text:
-- 1 "Metalfoes" monster + 2 monsters with 3000 or less ATK
--[[ __CARD_HEADER_END__ ]]

--メタルフォーゼ・カーディナル
function c54401832.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcFunFun(c,aux.FilterBoolFunction(Card.IsFusionSetCard,0xe1),aux.FilterBoolFunction(Card.IsAttackBelow,3000),2,true)
end
