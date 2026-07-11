--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:43
-- Source DB: cards.cdb
-- Card: Flash Knight  (ID: 17390179)
-- Type: Monster / Normal / Pendulum
-- Attribute: LIGHT
-- Race: Warrior
-- Level: 4
-- ATK 1800 | DEF 600
-- Pendulum Scale: L7 / R7
-- Scope: OCG / TCG
--
-- Effect Text:
-- Pendulum Scale = 7
-- ----------------------------------------
-- [ Monster Effect ]
-- The power of the pendulum flashes forth from this shining knight.
--[[ __CARD_HEADER_END__ ]]

--閃光の騎士
function c17390179.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c)
end
