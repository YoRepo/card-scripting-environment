--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:54
-- Source DB: cards.cdb
-- Card: Gaia Knight, the Force of Earth  (ID: 97204936)
-- Type: Monster / Synchro
-- Attribute: EARTH
-- Race: Warrior
-- Level: 6
-- ATK 2600 | DEF 800
-- Scope: OCG / TCG
--
-- Effect Text:
-- 1 Tuner + 1 or more non-Tuner monsters
--[[ __CARD_HEADER_END__ ]]

--大地の騎士ガイアナイト
function c97204936.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure(c,nil,aux.NonTuner(nil),1)
	c:EnableReviveLimit()
end
