--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:44
-- Source DB: cards.cdb
-- Card: Gallugallud the Endless Enigma  (ID: 32872239)
-- Type: Monster / Normal / Pendulum
-- Attribute: FIRE
-- Race: Fiend
-- Level: 6
-- ATK 2000 | DEF 2000
-- Pendulum Scale: L9 / R9
-- Scope: OCG / TCG
--
-- Effect Text:
-- Pendulum Scale = 9
-- ----------------------------------------
-- [ Monster Effect ]
-- This sinister spirit of wavering flames can transform into any being. As it shifts from bird to
-- human, and human to bird, it has forgotten its true self.
--[[ __CARD_HEADER_END__ ]]

--ガルガルドの屍煉魔
local s,id,o=GetID()
function s.initial_effect(c)
	aux.EnablePendulumAttribute(c)
end
