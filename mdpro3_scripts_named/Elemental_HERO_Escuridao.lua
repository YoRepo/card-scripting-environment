--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:45
-- Source DB: cards.cdb
-- Card: Elemental HERO Escuridao  (ID: 33574806)
-- Type: Monster / Effect / Fusion
-- Attribute: DARK
-- Race: Warrior
-- Level: 8
-- ATK 2500 | DEF 2000
-- Setcode: 0x3008
-- Scope: OCG / TCG
--
-- Effect Text:
-- 1 "Elemental HERO" monster + 1 DARK monster
-- Must be Fusion Summoned.
-- Gains 100 ATK for each "Elemental HERO" monster in your GY.
--[[ __CARD_HEADER_END__ ]]

--E・HERO エスクリダオ
function c33574806.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcFun2(c,aux.FilterBoolFunction(Card.IsFusionSetCard,0x3008),aux.FilterBoolFunction(Card.IsFusionAttribute,ATTRIBUTE_DARK),true)
	--spsummon condition
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e2:SetCode(EFFECT_SPSUMMON_CONDITION)
	e2:SetValue(aux.fuslimit)
	c:RegisterEffect(e2)
	--atkup
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCode(EFFECT_UPDATE_ATTACK)
	e3:SetValue(c33574806.atkup)
	c:RegisterEffect(e3)
end
c33574806.material_setcode=0x8
function c33574806.atkfilter(c)
	return c:IsSetCard(0x3008) and c:IsType(TYPE_MONSTER)
end
function c33574806.atkup(e,c)
	return Duel.GetMatchingGroupCount(c33574806.atkfilter,c:GetControler(),LOCATION_GRAVE,0,nil)*100
end
