--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 标枪甲虫  (ID: 26932788)
-- Type: Monster / Ritual
-- Attribute: EARTH
-- Race: Insect
-- Level 8
-- ATK 2450 | DEF 2550
--
-- Effect Text:
-- 借由「标枪甲虫的契约」降临。必须从场上或者手札，牺牲奉献等级合计为8个以上的卡。
--[[ __CARD_HEADER_END__ ]]

--ジャベリンビートル
function c26932788.initial_effect(c)
	aux.AddCodeList(c,41182875)
	c:EnableReviveLimit()
end
