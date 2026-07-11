--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:53
-- Source DB: cards.cdb
-- Card: Cyber Saurus  (ID: 89112729)
-- Type: Monster / Fusion
-- Attribute: EARTH
-- Race: Machine
-- Level: 5
-- ATK 1800 | DEF 1400
-- Scope: OCG / TCG
--
-- Effect Text:
-- "Blast Juggler" + "Two-Headed King Rex"
--
-- (This card is not treated as a "Cyber" card.)
--[[ __CARD_HEADER_END__ ]]

--メカ・ザウルス
function c89112729.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCode2(c,70138455,94119974,true,true)
end
