--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:52
-- Source DB: cards.cdb
-- Card: Dragong  (ID: 83980492)
-- Type: Monster / Normal / Pendulum
-- Attribute: EARTH
-- Race: Machine
-- Level: 4
-- ATK 500 | DEF 2100
-- Pendulum Scale: L7 / R7
-- Scope: OCG / TCG
--
-- Effect Text:
-- Pendulum Scale = 7
-- ----------------------------------------
-- [ Monster Effect ]
-- This gong harbors the soul of an untamed dragon. It soars through the skies with an incredible roar,
-- marshaling all those who hear its call to battle.
--[[ __CARD_HEADER_END__ ]]

--銅鑼ドラゴン
function c83980492.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c)
end
