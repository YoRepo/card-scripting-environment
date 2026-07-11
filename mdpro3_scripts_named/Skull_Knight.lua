--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:44
-- Source DB: cards.cdb
-- Card: Skull Knight  (ID: 2504891)
-- Type: Monster / Fusion
-- Attribute: DARK
-- Race: Spellcaster
-- Level: 7
-- ATK 2650 | DEF 2250
-- Scope: OCG / TCG
--
-- Effect Text:
-- "Tainted Wisdom" + "Ancient Brain"
--[[ __CARD_HEADER_END__ ]]

--スカルビショップ
function c2504891.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCode2(c,28725004,42431843,true,true)
end
