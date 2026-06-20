--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 查克拉  (ID: 65393205)
-- Type: Monster / Ritual
-- Attribute: DARK
-- Race: Fiend
-- Level 7
-- ATK 2450 | DEF 2000
--
-- Effect Text:
-- 借由「查克拉的复活」降临。必须从场上或者手札，牺牲奉献等级合计为7个以上的卡。
--[[ __CARD_HEADER_END__ ]]

--チャクラ
function c65393205.initial_effect(c)
	aux.AddCodeList(c,39399168)
	c:EnableReviveLimit()
end
