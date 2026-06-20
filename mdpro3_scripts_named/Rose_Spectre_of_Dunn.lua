--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:26
-- Card: 栖身蔷薇的恶灵  (ID: 32485271)
-- Type: Monster / Fusion
-- Attribute: DARK
-- Race: Plant
-- Level 6
-- ATK 2000 | DEF 1800
--
-- Effect Text:
-- 「小精怪」＋「蛇椰树」
--[[ __CARD_HEADER_END__ ]]

--バラに棲む悪霊
function c32485271.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCode2(c,41392891,29802344,true,true)
end
