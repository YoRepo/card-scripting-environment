--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 要塞鲸  (ID: 62337487)
-- Type: Monster / Ritual
-- Attribute: WATER
-- Race: Fish
-- Level 7
-- ATK 2350 | DEF 2150
--
-- Effect Text:
-- 借由「要塞鲸的誓言」降临。必须从场上或者手札，牺牲奉献等级合计为7个以上的卡。
--[[ __CARD_HEADER_END__ ]]

--要塞クジラ
function c62337487.initial_effect(c)
	aux.AddCodeList(c,77454922)
	c:EnableReviveLimit()
end
