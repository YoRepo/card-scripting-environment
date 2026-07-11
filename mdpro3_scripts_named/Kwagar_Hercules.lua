--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:53
-- Source DB: cards.cdb
-- Card: Kwagar Hercules  (ID: 95144193)
-- Type: Monster / Fusion
-- Attribute: EARTH
-- Race: Insect
-- Level: 6
-- ATK 1900 | DEF 1700
-- Scope: OCG / TCG
--
-- Effect Text:
-- "Kuwagata α" + "Hercules Beetle"
--[[ __CARD_HEADER_END__ ]]

--クワガー・ヘラクレス
function c95144193.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCode2(c,60802233,52584282,true,true)
end
