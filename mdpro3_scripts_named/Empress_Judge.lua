--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:43
-- Source DB: cards.cdb
-- Card: Empress Judge  (ID: 15237615)
-- Type: Monster / Fusion
-- Attribute: EARTH
-- Race: Warrior
-- Level: 6
-- ATK 2100 | DEF 1700
-- Scope: OCG / TCG
--
-- Effect Text:
-- "Queen's Double" + "Hibikime"
--[[ __CARD_HEADER_END__ ]]

--裁きを下す女帝
function c15237615.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCode2(c,5901497,64501875,true,true)
end
