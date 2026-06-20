--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:26
-- Card: 天威之拳僧  (ID: 32519092)
-- Type: Monster / Link
-- Attribute: EARTH
-- Race: Wyrm
-- ATK 1000 | LINK
-- Setcode: 300
--
-- Effect Text:
-- 连接怪兽以外的「天威」怪兽1只
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
