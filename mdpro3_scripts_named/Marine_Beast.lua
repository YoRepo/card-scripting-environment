--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 海兽鱼  (ID: 29929832)
-- Type: Monster / Fusion
-- Attribute: WATER
-- Race: Fish
-- Level 5
-- ATK 1700 | DEF 1600
--
-- Effect Text:
-- 「水之魔导师」＋「大肚海蛇」
--[[ __CARD_HEADER_END__ ]]

--マリン・ビースト
function c29929832.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCode2(c,93343894,94022093,true,true)
end
