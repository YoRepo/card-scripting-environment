--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 电影之骑士 盖亚剑士  (ID: 67598234)
-- Type: Monster / Link
-- Attribute: EARTH
-- Race: Machine
-- ATK 2600 | LINK
-- Setcode: 13
--
-- Effect Text:
-- 怪兽2只以上
--[[ __CARD_HEADER_END__ ]]

--電影の騎士ガイアセイバー
function c67598234.initial_effect(c)
	--link summon
	aux.AddLinkProcedure(c,nil,2)
	c:EnableReviveLimit()
end
