--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:31
-- Card: 奇迹鸟  (ID: 59036972)
-- Type: Monster / Fusion
-- Attribute: WIND
-- Race: Winged Beast
-- Level 4
-- ATK 1300 | DEF 900
--
-- Effect Text:
-- 「大炮鸟」＋「邪炎之翼」
--[[ __CARD_HEADER_END__ ]]

--マブラス
function c59036972.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCode2(c,72842870,92944626,true,true)
end
