--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:53
-- Source DB: cards.cdb
-- Card: Metal Dragon  (ID: 9293977)
-- Type: Monster / Fusion
-- Attribute: WIND
-- Race: Machine
-- Level: 6
-- ATK 1850 | DEF 1700
-- Scope: OCG / TCG
--
-- Effect Text:
-- "Steel Ogre Grotto #1" + "Lesser Dragon"
--[[ __CARD_HEADER_END__ ]]

--メタル・ドラゴン
function c9293977.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCode2(c,29172562,55444629,true,true)
end
