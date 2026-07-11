--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:43
-- Source DB: cards.cdb
-- Card: Magical Cavalry of Cxulub  (ID: 23220863)
-- Type: Monster / Effect / Pendulum
-- Attribute: EARTH
-- Race: Dinosaur
-- Level: 4
-- ATK 1500 | DEF 1800
-- Pendulum Scale: L3 / R3
-- Scope: OCG / TCG
--
-- Effect Text:
-- Pendulum Scale = 3
-- ----------------------------------------
-- [ Monster Effect ]
-- This card is unaffected by monsters' activated effects, except Pendulum Monsters'.
--[[ __CARD_HEADER_END__ ]]

--シュルブの魔導騎兵
function c23220863.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c)
	--immune
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_IMMUNE_EFFECT)
	e1:SetValue(c23220863.efilter)
	c:RegisterEffect(e1)
end
function c23220863.efilter(e,te)
	return te:IsActiveType(TYPE_MONSTER) and te:IsActivated() and not te:GetOwner():IsType(TYPE_PENDULUM)
end
