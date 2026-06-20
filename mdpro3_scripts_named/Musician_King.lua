--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:31
-- Card: 音乐家帝王  (ID: 56907389)
-- Type: Monster / Fusion
-- Attribute: LIGHT
-- Race: Spellcaster
-- Level 5
-- ATK 1750 | DEF 1500
--
-- Effect Text:
-- 「黑森林的魔女」＋「高等女祭司」
--[[ __CARD_HEADER_END__ ]]

--音楽家の帝王
function c56907389.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCode2(c,78010363,17358176,true,true)
end
