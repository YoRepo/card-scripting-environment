--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:42
-- Source DB: cards.cdb
-- Card: First of the Dragons  (ID: 10817524)
-- Type: Monster / Effect / Fusion
-- Attribute: DARK
-- Race: Dragon
-- Level: 9
-- ATK 2700 | DEF 2000
-- Scope: OCG / TCG
--
-- Effect Text:
-- 2 Normal Monsters
-- Must be Fusion Summoned and cannot be Special Summoned by other ways.
-- You can only control 1 "First of the Dragons".
-- This card cannot be destroyed by battle, except by battle with a Normal Monster, and is unaffected
-- by other monsters' effects.
--[[ __CARD_HEADER_END__ ]]

--始祖竜ワイアーム
function c10817524.initial_effect(c)
	c:SetUniqueOnField(1,0,10817524)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcFunRep(c,aux.FilterBoolFunction(Card.IsFusionType,TYPE_NORMAL),2,true)
	--spsummon condition
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetValue(aux.fuslimit)
	c:RegisterEffect(e1)
	--indes
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e2:SetValue(c10817524.indval)
	c:RegisterEffect(e2)
	--immune
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCode(EFFECT_IMMUNE_EFFECT)
	e3:SetValue(c10817524.efilter)
	c:RegisterEffect(e3)
end
function c10817524.indval(e,c)
	return not c:IsType(TYPE_NORMAL)
end
function c10817524.efilter(e,te)
	return te:IsActiveType(TYPE_MONSTER) and te:GetOwner()~=e:GetOwner()
end
