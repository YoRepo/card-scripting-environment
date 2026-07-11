--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:43
-- Source DB: cards.cdb
-- Card: Mandragon  (ID: 19474136)
-- Type: Monster / Normal / Pendulum
-- Attribute: EARTH
-- Race: Plant
-- Level: 5
-- ATK 2500 | DEF 1000
-- Pendulum Scale: L2 / R2
-- Scope: OCG / TCG
--
-- Effect Text:
-- Pendulum Scale = 2
-- ----------------------------------------
-- [ Monster Effect ]
-- This mandragora harbors the soul of a sorrowful dragon. The cursed tones of its wailing cause both
-- fear and despair.
--[[ __CARD_HEADER_END__ ]]

--マンドラゴン
function c19474136.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c)
end
