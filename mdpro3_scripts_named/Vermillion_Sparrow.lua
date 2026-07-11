--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:45
-- Source DB: cards.cdb
-- Card: Vermillion Sparrow  (ID: 35752363)
-- Type: Monster / Fusion
-- Attribute: FIRE
-- Race: Pyro
-- Level: 5
-- ATK 1900 | DEF 1500
-- Scope: OCG / TCG
--
-- Effect Text:
-- "Rhaimundos of the Red Sword" + "Fireyarou"
--[[ __CARD_HEADER_END__ ]]

--朱雀
function c35752363.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCode2(c,62403074,71407486,true,true)
end
