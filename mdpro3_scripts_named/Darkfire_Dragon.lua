--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:24
-- Card: 暗黑火炎龙  (ID: 17881964)
-- Type: Monster / Fusion
-- Attribute: DARK
-- Race: Dragon
-- Level 4
-- ATK 1500 | DEF 1250
--
-- Effect Text:
-- 「火炎草」＋「小龙」
--[[ __CARD_HEADER_END__ ]]

--暗黒火炎龍
function c17881964.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCode2(c,53293545,75356564,true,true)
end
