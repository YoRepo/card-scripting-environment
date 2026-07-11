--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:50
-- Source DB: cards.cdb
-- Card: Flame Ghost  (ID: 58528964)
-- Type: Monster / Fusion
-- Attribute: DARK
-- Race: Zombie
-- Level: 3
-- ATK 1000 | DEF 800
-- Scope: OCG / TCG
--
-- Effect Text:
-- "Skull Servant" + "Dissolverock"
--[[ __CARD_HEADER_END__ ]]

--フレイム・ゴースト
function c58528964.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCode2(c,32274490,40826495,true,true)
end
