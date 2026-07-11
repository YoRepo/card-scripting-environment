--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:49
-- Source DB: cards.cdb
-- Card: Humanoid Worm Drake  (ID: 5600127)
-- Type: Monster / Fusion
-- Attribute: WATER
-- Race: Aqua
-- Level: 7
-- ATK 2200 | DEF 2000
-- Scope: OCG / TCG
--
-- Effect Text:
-- "Worm Drake" + "Humanoid Slime"
--[[ __CARD_HEADER_END__ ]]

--ヒューマノイド・ドレイク
function c5600127.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCode2(c,73216412,46821314,true,true)
end
