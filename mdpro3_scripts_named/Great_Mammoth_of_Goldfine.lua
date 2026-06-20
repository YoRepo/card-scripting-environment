--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:30
-- Card: 金色的魔象  (ID: 54622031)
-- Type: Monster / Fusion
-- Attribute: DARK
-- Race: Zombie
-- Level 6
-- ATK 2200 | DEF 1800
--
-- Effect Text:
-- 「美杜莎的亡灵」＋「龙僵尸」
--[[ __CARD_HEADER_END__ ]]

--金色の魔象
function c54622031.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCode2(c,29491031,66672569,true,true)
end
