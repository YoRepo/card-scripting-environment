--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:30
-- Card: 三眼小巫师  (ID: 53539634)
-- Type: Monster / Fusion
-- Attribute: DARK
-- Race: Spellcaster
-- Level 6
-- ATK 2100 | DEF 1800
--
-- Effect Text:
-- 「三眼怪」＋「黑森林的魔女」
--[[ __CARD_HEADER_END__ ]]

--クリッチー
function c53539634.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCode2(c,78010363,26202165,true,true)
end
