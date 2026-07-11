--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:44
-- Source DB: cards.cdb
-- Card: Monk of the Tenyi  (ID: 32519092)
-- Type: Monster / Link
-- Attribute: EARTH
-- Race: Wyrm
-- Link Rating: 1
-- Link Arrows: Bottom
-- ATK 1000
-- Setcode: 0x12c
-- Scope: OCG / TCG
--
-- Effect Text:
-- 1 non-Link "Tenyi" monster
--[[ __CARD_HEADER_END__ ]]

--天威の拳僧
function c32519092.initial_effect(c)
	--link summon
	aux.AddLinkProcedure(c,c32519092.matfilter,1,1)
	c:EnableReviveLimit()
end
function c32519092.matfilter(c)
	return c:IsLinkSetCard(0x12c) and not c:IsLinkType(TYPE_LINK)
end
