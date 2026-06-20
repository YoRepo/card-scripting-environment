--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 巴洛克斯  (ID: 6840573)
-- Type: Monster / Fusion
-- Attribute: DARK
-- Race: Fiend
-- Level 5
-- ATK 1380 | DEF 1530
--
-- Effect Text:
-- 「杀人熊猫」＋「石像怪」
--[[ __CARD_HEADER_END__ ]]

--バロックス
function c6840573.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCode2(c,98818516,15303296,true,true)
end
