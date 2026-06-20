--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: 废铁死亡恶魔  (ID: 45815891)
-- Type: Monster / Synchro
-- Attribute: EARTH
-- Race: Fiend
-- Level 7
-- ATK 2700 | DEF 1800
-- Setcode: 4522020
--
-- Effect Text:
-- 调整＋调整以外的怪兽1只以上
--[[ __CARD_HEADER_END__ ]]

--スクラップ・デスデーモン
function c45815891.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure(c,nil,aux.NonTuner(nil),1)
	c:EnableReviveLimit()
end
