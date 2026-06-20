--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:30
-- Card: 双头雷龙  (ID: 54752875)
-- Type: Monster / Fusion
-- Attribute: LIGHT
-- Race: Thunder
-- Level 7
-- ATK 2800 | DEF 2100
-- Setcode: 284
--
-- Effect Text:
-- 「雷龙」＋「雷龙」
--[[ __CARD_HEADER_END__ ]]

--双頭の雷龍
function c54752875.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCodeRep(c,31786629,2,true,true)
end
