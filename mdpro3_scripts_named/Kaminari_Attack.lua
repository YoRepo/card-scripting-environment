--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:37
-- Card: 雷神之怒  (ID: 9653271)
-- Type: Monster / Fusion
-- Attribute: WIND
-- Race: Thunder
-- Level 5
-- ATK 1900 | DEF 1400
--
-- Effect Text:
-- 「耳天使」＋「大雷电球」
--[[ __CARD_HEADER_END__ ]]

--雷神の怒り
function c9653271.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCode2(c,86088138,21817254,true,true)
end
