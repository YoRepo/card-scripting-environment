--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:37
-- Card: 大地之骑士 盖亚骑士  (ID: 97204936)
-- Type: Monster / Synchro
-- Attribute: EARTH
-- Race: Warrior
-- Level 6
-- ATK 2600 | DEF 800
--
-- Effect Text:
-- 调整＋调整以外的怪兽1只以上
--[[ __CARD_HEADER_END__ ]]

--大地の騎士ガイアナイト
function c97204936.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure(c,nil,aux.NonTuner(nil),1)
	c:EnableReviveLimit()
end
