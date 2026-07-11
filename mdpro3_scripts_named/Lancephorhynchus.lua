--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:47
-- Source DB: cards.cdb
-- Card: Lancephorhynchus  (ID: 48940337)
-- Type: Monster / Normal / Pendulum
-- Attribute: WIND
-- Race: Dinosaur
-- Level: 6
-- ATK 2500 | DEF 800
-- Pendulum Scale: L7 / R7
-- Scope: OCG / TCG
--
-- Effect Text:
-- Pendulum Scale = 7
-- [ Pendulum Effect ]
-- If a Normal Monster you control attacks a Defense Position monster, inflict piercing battle damage
-- to your opponent.
-- ----------------------------------------
-- [ Monster Effect ]
-- This primordial species survived extinction by evolving an offensive lance that can pierce anything,
-- although its diet still consists mainly of fish.
--[[ __CARD_HEADER_END__ ]]

--ランスフォリンクス
function c48940337.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c)
	--pierce
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_PIERCE)
	e2:SetRange(LOCATION_PZONE)
	e2:SetTargetRange(LOCATION_MZONE,0)
	e2:SetTarget(c48940337.target)
	c:RegisterEffect(e2)
end
function c48940337.target(e,c)
	return c:IsType(TYPE_NORMAL)
end
