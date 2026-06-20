--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 宝石骑士·珍珠  (ID: 71594310)
-- Type: Monster / Xyz
-- Attribute: EARTH
-- Race: Rock
-- Rank 4
-- ATK 2600 | DEF 1900
-- Setcode: 4167
--
-- Effect Text:
-- 4星怪兽×2
--[[ __CARD_HEADER_END__ ]]

--ジェムナイト・パール
function c71594310.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,nil,4,2)
	c:EnableReviveLimit()
end
