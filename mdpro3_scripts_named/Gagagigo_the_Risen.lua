--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:53
-- Source DB: cards.cdb
-- Card: Gagagigo the Risen  (ID: 9053187)
-- Type: Monster / Xyz
-- Attribute: WATER
-- Race: Reptile
-- Rank: 4
-- ATK 2950 | DEF 2800
-- Scope: OCG / TCG
--
-- Effect Text:
-- 3 Level 4 monsters
--[[ __CARD_HEADER_END__ ]]

--覚醒の勇士 ガガギゴ
function c9053187.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,nil,4,3)
	c:EnableReviveLimit()
end
