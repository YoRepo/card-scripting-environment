--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:30
-- Card: 炭烧战士  (ID: 54541900)
-- Type: Monster / Fusion
-- Attribute: EARTH
-- Race: Warrior
-- Level 4
-- ATK 1500 | DEF 1200
--
-- Effect Text:
-- 「磁力战士1号」＋「磁力战士2号」
--[[ __CARD_HEADER_END__ ]]

--カルボナーラ戦士
function c54541900.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCode2(c,56342351,92731455,true,true)
end
