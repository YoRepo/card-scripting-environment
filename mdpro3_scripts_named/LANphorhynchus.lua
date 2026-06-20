--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: LAN喙嘴龙  (ID: 77637979)
-- Type: Monster / Link
-- Attribute: LIGHT
-- Race: Cyberse
-- ATK 1200 | LINK
--
-- Effect Text:
-- 怪兽2只
--[[ __CARD_HEADER_END__ ]]

--LANフォリンクス
function c77637979.initial_effect(c)
	--link summon
	c:EnableReviveLimit()
	aux.AddLinkProcedure(c,nil,2,2)
end
