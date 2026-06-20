--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 裁决之鹰  (ID: 74703140)
-- Type: Monster / Fusion
-- Attribute: WIND
-- Race: Winged Beast
-- Level 6
-- ATK 2100 | DEF 1800
--
-- Effect Text:
-- 「苍翼冠鸟」＋「胖鸡」
--[[ __CARD_HEADER_END__ ]]

--裁きの鷹
function c74703140.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCode2(c,41396436,7805359,true,true)
end
