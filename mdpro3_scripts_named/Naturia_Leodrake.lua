--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:43
-- Source DB: cards.cdb
-- Card: Naturia Leodrake  (ID: 16527176)
-- Type: Monster / Synchro
-- Attribute: EARTH
-- Race: Beast
-- Level: 9
-- ATK 3000 | DEF 1800
-- Setcode: 0x2a
-- Scope: OCG / TCG
--
-- Effect Text:
-- 1 EARTH Tuner + 1+ non-Tuner EARTH monsters
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
