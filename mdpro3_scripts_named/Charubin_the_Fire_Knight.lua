--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:45
-- Source DB: cards.cdb
-- Card: Charubin the Fire Knight  (ID: 37421579)
-- Type: Monster / Fusion
-- Attribute: FIRE
-- Race: Pyro
-- Level: 3
-- ATK 1100 | DEF 800
-- Scope: OCG / TCG
--
-- Effect Text:
-- "Monster Egg" + "Hinotama Soul"
--[[ __CARD_HEADER_END__ ]]

--炎の騎士 キラー
function c37421579.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCode2(c,36121917,96851799,true,true)
end
