--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: 机械恐龙  (ID: 89112729)
-- Type: Monster / Fusion
-- Attribute: EARTH
-- Race: Machine
-- Level 5
-- ATK 1800 | DEF 1400
--
-- Effect Text:
-- 「炸弹先生」＋「双头恐龙王」
--[[ __CARD_HEADER_END__ ]]

--メカ・ザウルス
function c89112729.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCode2(c,70138455,94119974,true,true)
end
