--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 青眼究极龙  (ID: 23995346)
-- Type: Monster / Fusion
-- Attribute: LIGHT
-- Race: Dragon
-- Level 12
-- ATK 4500 | DEF 3800
-- Setcode: 221
--
-- Effect Text:
-- 「青眼白龙」＋「青眼白龙」＋「青眼白龙」
--[[ __CARD_HEADER_END__ ]]

--青眼の究極竜
function c23995346.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCodeRep(c,89631139,3,true,true)
end
