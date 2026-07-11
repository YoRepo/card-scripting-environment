--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:51
-- Source DB: cards.cdb
-- Card: Gem-Knight Pearl  (ID: 71594310)
-- Type: Monster / Xyz
-- Attribute: EARTH
-- Race: Rock
-- Rank: 4
-- ATK 2600 | DEF 1900
-- Setcode: 0x1047
-- Scope: OCG / TCG
--
-- Effect Text:
-- 2 Level 4 monsters
--[[ __CARD_HEADER_END__ ]]

--ジェムナイト・パール
function c71594310.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,nil,4,2)
	c:EnableReviveLimit()
end
