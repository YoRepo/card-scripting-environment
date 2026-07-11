--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:51
-- Source DB: cards.cdb
-- Card: Dragoness the Wicked Knight  (ID: 70681994)
-- Type: Monster / Fusion
-- Attribute: WIND
-- Race: Warrior
-- Level: 3
-- ATK 1200 | DEF 900
-- Scope: OCG / TCG
--
-- Effect Text:
-- "Armaill" + "One-Eyed Shield Dragon"
--[[ __CARD_HEADER_END__ ]]

--魔装騎士ドラゴネス
function c70681994.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCode2(c,53153481,33064647,true,true)
end
