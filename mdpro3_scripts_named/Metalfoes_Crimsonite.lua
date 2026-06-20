--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:30
-- Card: 炼装勇士·绯金红巨甲  (ID: 54401832)
-- Type: Monster / Fusion
-- Attribute: FIRE
-- Race: Psychic
-- Level 9
-- ATK 3000 | DEF 3000
-- Setcode: 225
--
-- Effect Text:
-- 「炼装」怪兽＋攻击力3000以下的怪兽×2
--[[ __CARD_HEADER_END__ ]]

--メタルフォーゼ・カーディナル
function c54401832.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcFunFun(c,aux.FilterBoolFunction(Card.IsFusionSetCard,0xe1),aux.FilterBoolFunction(Card.IsAttackBelow,3000),2,true)
end
