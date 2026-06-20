--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 炎之骑士 基拉  (ID: 37421579)
-- Type: Monster / Fusion
-- Attribute: FIRE
-- Race: Pyro
-- Level 3
-- ATK 1100 | DEF 800
--
-- Effect Text:
-- 「怪兽蛋」＋「史汀」
--[[ __CARD_HEADER_END__ ]]

--炎の騎士 キラー
function c37421579.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCode2(c,36121917,96851799,true,true)
end
