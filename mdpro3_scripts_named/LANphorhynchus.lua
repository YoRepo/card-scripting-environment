--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:52
-- Source DB: cards.cdb
-- Card: LANphorhynchus  (ID: 77637979)
-- Type: Monster / Link
-- Attribute: LIGHT
-- Race: Cyberse
-- Link Rating: 2
-- Link Arrows: Bottom-Left, Bottom-Right
-- ATK 1200
-- Scope: OCG / TCG
--
-- Effect Text:
-- 2 monsters
--[[ __CARD_HEADER_END__ ]]

--LANフォリンクス
function c77637979.initial_effect(c)
	--link summon
	c:EnableReviveLimit()
	aux.AddLinkProcedure(c,nil,2,2)
end
