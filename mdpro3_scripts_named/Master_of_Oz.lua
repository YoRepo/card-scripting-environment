--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: OZ之主  (ID: 27134689)
-- Type: Monster / Fusion
-- Attribute: EARTH
-- Race: Beast
-- Level 9
-- ATK 4200 | DEF 3700
--
-- Effect Text:
-- 「巨大树熊」＋「死亡袋鼠」
--[[ __CARD_HEADER_END__ ]]

--マスター・オブ・OZ
function c27134689.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCode2(c,42129512,78613627,true,true)
end
