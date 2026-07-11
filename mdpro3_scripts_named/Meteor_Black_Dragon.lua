--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:53
-- Source DB: cards.cdb
-- Card: Meteor Black Dragon  (ID: 90660762)
-- Type: Monster / Fusion
-- Attribute: FIRE
-- Race: Dragon
-- Level: 8
-- ATK 3500 | DEF 2000
-- Scope: OCG / TCG
--
-- Effect Text:
-- "Red-Eyes Black Dragon" + "Meteor Dragon"
--[[ __CARD_HEADER_END__ ]]

--メテオ・ブラック・ドラゴン
function c90660762.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCode2(c,74677422,64271667,true,true)
end
c90660762.material_setcode=0x3b
