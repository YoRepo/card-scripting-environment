--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 下达裁决的女帝  (ID: 15237615)
-- Type: Monster / Fusion
-- Attribute: EARTH
-- Race: Warrior
-- Level 6
-- ATK 2100 | DEF 1700
--
-- Effect Text:
-- 「女王的影武者」＋「响女」
--[[ __CARD_HEADER_END__ ]]

--裁きを下す女帝
function c15237615.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCode2(c,5901497,64501875,true,true)
end
