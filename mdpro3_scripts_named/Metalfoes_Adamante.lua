--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 炼装勇士·精金超人  (ID: 81612598)
-- Type: Monster / Fusion
-- Attribute: FIRE
-- Race: Psychic
-- Level 5
-- ATK 2500 | DEF 2500
-- Setcode: 225
--
-- Effect Text:
-- 「炼装」怪兽＋攻击力2500以下的怪兽
--[[ __CARD_HEADER_END__ ]]

--メタルフォーゼ・アダマンテ
function c81612598.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcFun2(c,aux.FilterBoolFunction(Card.IsFusionSetCard,0xe1),aux.FilterBoolFunction(Card.IsAttackBelow,2500),true)
end
