--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:49
-- Source DB: cards.cdb
-- Card: Sanwitch  (ID: 53539634)
-- Type: Monster / Fusion
-- Attribute: DARK
-- Race: Spellcaster
-- Level: 6
-- ATK 2100 | DEF 1800
-- Scope: OCG / TCG
--
-- Effect Text:
-- "Sangan" + "Witch of the Black Forest"
--[[ __CARD_HEADER_END__ ]]

--クリッチー
function c53539634.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCode2(c,78010363,26202165,true,true)
end
