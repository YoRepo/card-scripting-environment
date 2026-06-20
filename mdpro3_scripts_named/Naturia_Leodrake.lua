--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 自然狮面草  (ID: 16527176)
-- Type: Monster / Synchro
-- Attribute: EARTH
-- Race: Beast
-- Level 9
-- ATK 3000 | DEF 1800
-- Setcode: 42
--
-- Effect Text:
-- 地属性调整＋调整以外的地属性怪兽1只以上
--[[ __CARD_HEADER_END__ ]]

--ナチュル・ガオドレイク
function c16527176.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure(c,c16527176.synfilter,aux.NonTuner(c16527176.synfilter),1)
	c:EnableReviveLimit()
end
function c16527176.synfilter(c)
	return c:IsAttribute(ATTRIBUTE_EARTH)
end
