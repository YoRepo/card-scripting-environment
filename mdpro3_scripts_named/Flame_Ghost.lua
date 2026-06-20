--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:31
-- Card: 火焰幽灵  (ID: 58528964)
-- Type: Monster / Fusion
-- Attribute: DARK
-- Race: Zombie
-- Level 3
-- ATK 1000 | DEF 800
--
-- Effect Text:
-- 「白骨」＋「岩浆人」
--[[ __CARD_HEADER_END__ ]]

--フレイム・ゴースト
function c58528964.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCode2(c,32274490,40826495,true,true)
end
