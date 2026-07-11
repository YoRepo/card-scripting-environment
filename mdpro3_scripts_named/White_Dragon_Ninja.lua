--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:54
-- Source DB: cards.cdb
-- Card: White Dragon Ninja  (ID: 99212922)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Dragon
-- Level: 7
-- ATK 2700 | DEF 1200
-- Setcode: 0x2b
-- Scope: OCG / TCG
--
-- Effect Text:
-- Cannot be Special Summoned, except with a "Ninjitsu Art" card's effect.
-- Spells/Traps you control cannot be destroyed by card effects.
--[[ __CARD_HEADER_END__ ]]

--白竜の忍者
function c99212922.initial_effect(c)
	--spsummon limit
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetValue(c99212922.splimit)
	c:RegisterEffect(e1)
	--indes
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e2:SetProperty(EFFECT_FLAG_SET_AVAILABLE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(LOCATION_ONFIELD,0)
	e2:SetTarget(c99212922.indes)
	e2:SetValue(1)
	c:RegisterEffect(e2)
end
function c99212922.splimit(e,se,sp,st)
	return se:GetHandler():IsSetCard(0x61)
end
function c99212922.indes(e,c)
	return c:IsType(TYPE_SPELL+TYPE_TRAP)
end
