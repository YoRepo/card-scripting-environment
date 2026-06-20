--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:30
-- Card: 蒸汽旋翼机人  (ID: 5368615)
-- Type: Monster / Fusion
-- Attribute: EARTH
-- Race: Machine
-- Level 6
-- ATK 2200 | DEF 1600
-- Setcode: 22
--
-- Effect Text:
-- 「旋翼机人」＋「蒸汽机人」
--[[ __CARD_HEADER_END__ ]]

--スチームジャイロイド
function c5368615.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCode2(c,18325492,44729197,true,true)
end
