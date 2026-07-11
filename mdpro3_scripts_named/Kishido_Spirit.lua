--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:50
-- Source DB: cards.cdb
-- Card: Kishido Spirit  (ID: 60519422)
-- Type: Spell / Continuous
-- Scope: OCG / TCG
--
-- Effect Text:
-- Monsters on your side of the field cannot be destroyed in a battle if the monsters' ATK are equal.
--[[ __CARD_HEADER_END__ ]]

--騎士道精神
function c60519422.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--indes
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTargetRange(LOCATION_MZONE,0)
	e2:SetTarget(c60519422.indtg)
	e2:SetValue(c60519422.indval)
	c:RegisterEffect(e2)
end
function c60519422.indtg(e,c)
	e:SetLabel(c:GetAttack())
	return true
end
function c60519422.indval(e,c)
	return c:IsAttack(e:GetLabel())
end
