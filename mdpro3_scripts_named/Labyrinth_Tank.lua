--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:37
-- Card: 迷宫的魔战车  (ID: 99551425)
-- Type: Monster / Fusion
-- Attribute: DARK
-- Race: Machine
-- Level 7
-- ATK 2400 | DEF 2400
--
-- Effect Text:
-- 「高科技狼」＋「加农炮兵」
--[[ __CARD_HEADER_END__ ]]

--迷宮の魔戦車
function c99551425.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCode2(c,8471389,11384280,true,true)
end
