--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:51
-- Source DB: cards.cdb
-- Card: Gaia Saber, the Lightning Shadow  (ID: 67598234)
-- Type: Monster / Link
-- Attribute: EARTH
-- Race: Machine
-- Link Rating: 3
-- Link Arrows: Left, Right, Bottom
-- ATK 2600
-- Setcode: 0xd
-- Scope: OCG / TCG
--
-- Effect Text:
-- 2+ monsters
--[[ __CARD_HEADER_END__ ]]

--電影の騎士ガイアセイバー
function c67598234.initial_effect(c)
	--link summon
	aux.AddLinkProcedure(c,nil,2)
	c:EnableReviveLimit()
end
