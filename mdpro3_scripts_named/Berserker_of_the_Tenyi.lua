--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:30
-- Card: 天威之鬼神  (ID: 5402805)
-- Type: Monster / Link
-- Attribute: DARK
-- Race: Wyrm
-- ATK 3000 | LINK
-- Setcode: 300
--
-- Effect Text:
-- 包含连接怪兽的怪兽2只以上
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
