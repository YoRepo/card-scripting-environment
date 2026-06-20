--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 千年龙  (ID: 41462083)
-- Type: Monster / Fusion
-- Attribute: WIND
-- Race: Dragon
-- Level 7
-- ATK 2400 | DEF 2000
--
-- Effect Text:
-- 「时间魔术师」＋「宝贝龙」
--[[ __CARD_HEADER_END__ ]]

--千年竜
function c41462083.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCode2(c,71625222,88819587,true,true)
end
