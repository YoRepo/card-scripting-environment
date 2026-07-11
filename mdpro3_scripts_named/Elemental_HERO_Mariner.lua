--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:43
-- Source DB: cards.cdb
-- Card: Elemental HERO Mariner  (ID: 14225239)
-- Type: Monster / Effect / Fusion
-- Attribute: WATER
-- Race: Warrior
-- Level: 5
-- ATK 1400 | DEF 1000
-- Setcode: 0x3008
-- Scope: OCG / TCG
--
-- Effect Text:
-- "Elemental HERO Bubbleman" + "Elemental HERO Avian"
-- Must be Fusion Summoned.
-- While you have any Set card(s) in your Spell & Trap Zone, this card can attack your opponent
-- directly.
--[[ __CARD_HEADER_END__ ]]

--E・HERO セイラーマン
function c14225239.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCode2(c,79979666,21844576,true,true)
	--spsummon condition
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetValue(aux.fuslimit)
	c:RegisterEffect(e1)
	--direct attack
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_DIRECT_ATTACK)
	e2:SetCondition(c14225239.dacon)
	c:RegisterEffect(e2)
end
c14225239.material_setcode=0x8
function c14225239.filter(c)
	return c:IsFacedown() and c:GetSequence()~=5
end
function c14225239.dacon(e)
	return Duel.IsExistingMatchingCard(c14225239.filter,e:GetHandlerPlayer(),LOCATION_SZONE,0,1,nil)
end
