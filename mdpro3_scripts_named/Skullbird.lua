--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:52
-- Source DB: cards.cdb
-- Card: Skullbird  (ID: 8327462)
-- Type: Monster / Fusion
-- Attribute: WIND
-- Race: Winged Beast
-- Level: 6
-- ATK 1900 | DEF 1700
-- Scope: OCG / TCG
--
-- Effect Text:
-- "Takuhee" + "Temple of Skulls"
--[[ __CARD_HEADER_END__ ]]

--デス・バード
function c8327462.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCode2(c,3170832,732302,true,true)
end
