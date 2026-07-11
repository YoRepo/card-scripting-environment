--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:45
-- Source DB: cards.cdb
-- Card: Traffic Ghost  (ID: 41248270)
-- Type: Monster / Link
-- Attribute: DARK
-- Race: Cyberse
-- Link Rating: 3
-- Link Arrows: Bottom-Left, Bottom, Bottom-Right
-- ATK 1800
-- Scope: OCG / TCG
--
-- Effect Text:
-- 3 monsters
--[[ __CARD_HEADER_END__ ]]

--トラフィックゴースト
function c41248270.initial_effect(c)
	--link summon
	c:EnableReviveLimit()
	aux.AddLinkProcedure(c,nil,3,3)
end
