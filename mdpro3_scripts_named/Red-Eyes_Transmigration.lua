--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:46
-- Source DB: cards.cdb
-- Card: Red-Eyes Transmigration  (ID: 45410988)
-- Type: Spell / Ritual
-- Setcode: 0x3b
-- Scope: OCG / TCG
--
-- Effect Text:
-- This card is used to Ritual Summon "Lord of the Red".
-- You must also Tribute monsters from your hand or field, and/or banish "Red-Eyes" monsters from your
-- GY, whose total Levels equal 8 or more.
--[[ __CARD_HEADER_END__ ]]

--レッドアイズ・トランスマイグレーション
function c45410988.initial_effect(c)
	aux.AddRitualProcGreaterCode(c,19025379,nil,c45410988.mfilter)
end
function c45410988.mfilter(c)
	return c:IsSetCard(0x3b)
end
