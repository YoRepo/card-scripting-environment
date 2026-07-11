--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:48
-- Source DB: cards.cdb
-- Card: Giltia the D. Knight  (ID: 51828629)
-- Type: Monster / Fusion
-- Attribute: LIGHT
-- Race: Warrior
-- Level: 5
-- ATK 1850 | DEF 1500
-- Scope: OCG / TCG
--
-- Effect Text:
-- "Guardian of the Labyrinth" + "Protector of the Throne"
--[[ __CARD_HEADER_END__ ]]

--魔導騎士ギルティア
function c51828629.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCode2(c,89272878,10071456,true,true)
end
