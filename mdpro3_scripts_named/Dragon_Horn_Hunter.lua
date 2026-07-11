--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:43
-- Source DB: cards.cdb
-- Card: Dragon Horn Hunter  (ID: 21970285)
-- Type: Monster / Normal / Pendulum
-- Attribute: DARK
-- Race: Warrior
-- Level: 6
-- ATK 2300 | DEF 1000
-- Pendulum Scale: L3 / R3
-- Scope: OCG / TCG
--
-- Effect Text:
-- Pendulum Scale = 3
-- [ Pendulum Effect ]
-- All Normal Monsters on the field gain 200 ATK. You take no battle damage from battles involving
-- Normal Monsters you control.
-- ----------------------------------------
-- [ Monster Effect ]
-- The horns were needed to prepare a medicine for her village, suffering from a plague. Unknown to
-- her, the dragons burned and trampled her village, once displaced from their den.
--[[ __CARD_HEADER_END__ ]]

--竜角の狩猟者
function c21970285.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c)
	--atk
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetRange(LOCATION_PZONE)
	e2:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e2:SetTarget(c21970285.efilter)
	e2:SetValue(200)
	c:RegisterEffect(e2)
	--avoid battle damage
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_AVOID_BATTLE_DAMAGE)
	e3:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
	e3:SetRange(LOCATION_PZONE)
	e3:SetTargetRange(LOCATION_MZONE,0)
	e3:SetTarget(c21970285.efilter)
	e3:SetValue(1)
	c:RegisterEffect(e3)
end
function c21970285.efilter(e,c)
	return c:IsType(TYPE_NORMAL)
end
