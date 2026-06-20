--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 融合体  (ID: 1641882)
-- Type: Monster / Fusion
-- Attribute: EARTH
-- Race: Beast
-- Level 3
-- ATK 900 | DEF 700
--
-- Effect Text:
-- 「小天使」＋「催眠羊」
--[[ __CARD_HEADER_END__ ]]

--フュージョニスト
function c1641882.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCode2(c,38142739,83464209,true,true)
end
