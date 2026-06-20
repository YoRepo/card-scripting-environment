--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: 炎之剑士  (ID: 45231177)
-- Type: Monster / Fusion
-- Attribute: FIRE
-- Race: Warrior
-- Level 5
-- ATK 1800 | DEF 1600
--
-- Effect Text:
-- 「火焰操纵者」＋「传说的剑豪 正树」
--[[ __CARD_HEADER_END__ ]]

--炎の剣士
function c45231177.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCode2(c,34460851,44287299,true,true)
end
