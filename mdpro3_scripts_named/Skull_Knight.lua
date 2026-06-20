--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 骷髅祭司  (ID: 2504891)
-- Type: Monster / Fusion
-- Attribute: DARK
-- Race: Spellcaster
-- Level 7
-- ATK 2650 | DEF 2250
--
-- Effect Text:
-- 「恶魔的智慧」＋「魔天老」
--[[ __CARD_HEADER_END__ ]]

--スカルビショップ
function c2504891.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCode2(c,28725004,42431843,true,true)
end
