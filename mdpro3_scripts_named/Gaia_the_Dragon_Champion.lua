--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 龙骑士 盖亚  (ID: 66889139)
-- Type: Monster / Fusion
-- Attribute: WIND
-- Race: Dragon
-- Level 7
-- ATK 2600 | DEF 2100
--
-- Effect Text:
-- 「暗黑骑士 盖亚」＋「诅咒之龙」
--[[ __CARD_HEADER_END__ ]]

--竜騎士ガイア
function c66889139.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCode2(c,6368038,28279543,true,true)
end
