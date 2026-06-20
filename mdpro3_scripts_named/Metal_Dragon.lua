--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:36
-- Card: 金属龙  (ID: 9293977)
-- Type: Monster / Fusion
-- Attribute: WIND
-- Race: Machine
-- Level 6
-- ATK 1850 | DEF 1700
--
-- Effect Text:
-- 「钢铁巨神像」＋「下级龙」
--[[ __CARD_HEADER_END__ ]]

--メタル・ドラゴン
function c9293977.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCode2(c,29172562,55444629,true,true)
end
