--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 水陆两用战斗艇  (ID: 40173854)
-- Type: Monster / Fusion
-- Attribute: WATER
-- Race: Aqua
-- Level 5
-- ATK 1850 | DEF 1300
--
-- Effect Text:
-- 「陆战型战斗艇」＋「守卫海洋的战士」
--[[ __CARD_HEADER_END__ ]]

--水陸両用バグロス
function c40173854.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCode2(c,58314394,85448931,true,true)
end
