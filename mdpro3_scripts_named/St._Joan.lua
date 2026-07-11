--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:43
-- Source DB: cards.cdb
-- Card: St. Joan  (ID: 21175632)
-- Type: Monster / Fusion
-- Attribute: LIGHT
-- Race: Fairy
-- Level: 7
-- ATK 2800 | DEF 2000
-- Scope: OCG / TCG
--
-- Effect Text:
-- "The Forgiving Maiden" + "Darklord Marie"
--[[ __CARD_HEADER_END__ ]]

--聖女ジャンヌ
function c21175632.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCode2(c,84080938,57579381,true,true)
end
