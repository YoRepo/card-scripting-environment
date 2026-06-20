--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 流量幽灵  (ID: 41248270)
-- Type: Monster / Link
-- Attribute: DARK
-- Race: Cyberse
-- ATK 1800 | LINK
--
-- Effect Text:
-- 怪兽3只
--[[ __CARD_HEADER_END__ ]]

--トラフィックゴースト
function c41248270.initial_effect(c)
	--link summon
	c:EnableReviveLimit()
	aux.AddLinkProcedure(c,nil,3,3)
end
