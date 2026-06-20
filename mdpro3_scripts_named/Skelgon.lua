--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:26
-- Card: 骸骨龙  (ID: 32355828)
-- Type: Monster / Fusion
-- Attribute: DARK
-- Race: Zombie
-- Level 6
-- ATK 1700 | DEF 1900
--
-- Effect Text:
-- 「美杜莎的亡灵」＋「暗黑之龙王」
--[[ __CARD_HEADER_END__ ]]

--スケルゴン
function c32355828.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCode2(c,29491031,87564352,true,true)
end
