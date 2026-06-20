--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 混沌男巫  (ID: 41544074)
-- Type: Monster / Fusion
-- Attribute: DARK
-- Race: Spellcaster
-- Level 4
-- ATK 1300 | DEF 1100
-- Setcode: 207
--
-- Effect Text:
-- 「圣精灵」＋「黑魔族的幕帘」
--[[ __CARD_HEADER_END__ ]]

--カオス・ウィザード
function c41544074.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCode2(c,15025844,22026707,true,true)
end
