--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: 觉醒的勇士 魔蜥义豪  (ID: 9053187)
-- Type: Monster / Xyz
-- Attribute: WATER
-- Race: Reptile
-- Rank 4
-- ATK 2950 | DEF 2800
--
-- Effect Text:
-- 4星怪兽×3
--[[ __CARD_HEADER_END__ ]]

--覚醒の勇士 ガガギゴ
function c9053187.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,nil,4,3)
	c:EnableReviveLimit()
end
