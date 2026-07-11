--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:46
-- Source DB: cards.cdb
-- Card: Scrap Archfiend  (ID: 45815891)
-- Type: Monster / Synchro
-- Attribute: EARTH
-- Race: Fiend
-- Level: 7
-- ATK 2700 | DEF 1800
-- Setcode: 0x24, 0x45
-- Scope: OCG / TCG
--
-- Effect Text:
-- 1 Tuner + 1+ non-Tuner monsters
--[[ __CARD_HEADER_END__ ]]

--スクラップ・デスデーモン
function c45815891.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure(c,nil,aux.NonTuner(nil),1)
	c:EnableReviveLimit()
end
