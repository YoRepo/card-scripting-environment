--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:44
-- Source DB: cards.cdb
-- Card: Fire Opal Head  (ID: 28363749)
-- Type: Monster / Normal / Pendulum
-- Attribute: FIRE
-- Race: Dinosaur
-- Level: 6
-- ATK 2500 | DEF 1000
-- Scope: OCG / TCG
--
-- Effect Text:
-- Pendulum Scale = 0
-- ----------------------------------------
-- [ Monster Effect ]
-- This dinosaur pack leader with a burning head of stone is named after his finishing move.
--[[ __CARD_HEADER_END__ ]]

--ファイヤーオパールヘッド
function c28363749.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c)
end
