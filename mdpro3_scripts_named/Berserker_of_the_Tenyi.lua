--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:49
-- Source DB: cards.cdb
-- Card: Berserker of the Tenyi  (ID: 5402805)
-- Type: Monster / Link
-- Attribute: DARK
-- Race: Wyrm
-- Link Rating: 3
-- Link Arrows: Top, Top-Right, Bottom-Right
-- ATK 3000
-- Setcode: 0x12c
-- Scope: OCG / TCG
--
-- Effect Text:
-- 2+ monsters, including a Link Monster
--[[ __CARD_HEADER_END__ ]]

--天威の鬼神
function c5402805.initial_effect(c)
	--link summon
	aux.AddLinkProcedure(c,nil,2,3,c5402805.lcheck)
	c:EnableReviveLimit()
end
function c5402805.lcheck(g,lc)
	return g:IsExists(Card.IsLinkType,1,nil,TYPE_LINK)
end
