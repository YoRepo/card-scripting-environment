--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:52
-- Source DB: cards.cdb
-- Card: Buster Blader, the Dragon Destroyer Swordsman  (ID: 86240887)
-- Type: Monster / Effect / Fusion
-- Attribute: LIGHT
-- Race: Warrior
-- Level: 8
-- ATK 2800 | DEF 2500
-- Setcode: 0xd7
-- Scope: OCG / TCG
--
-- Effect Text:
-- 1 "Buster Blader" + 1 Dragon monster
-- Must be Fusion Summoned.
-- Cannot attack directly.
-- Gains 1000 ATK/DEF for each Dragon monster your opponent controls or is in their GY.
-- Change all Dragon monsters your opponent controls to Defense Position, also Dragon monsters in your
-- opponent's possession cannot activate their effects.
-- If this card attacks a Defense Position monster, inflict piercing battle damage.
--[[ __CARD_HEADER_END__ ]]

--竜破壊の剣士－バスター・ブレイダー
function c86240887.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCodeFun(c,78193831,aux.FilterBoolFunction(Card.IsRace,RACE_DRAGON),1,true,true)
	--cannot direct attack
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_CANNOT_DIRECT_ATTACK)
	c:RegisterEffect(e1)
	--ATK Gain
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetRange(LOCATION_MZONE)
	e2:SetValue(c86240887.val)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EFFECT_UPDATE_DEFENSE)
	c:RegisterEffect(e3)
	--spsummon condition
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e4:SetCode(EFFECT_SPSUMMON_CONDITION)
	e4:SetValue(aux.fuslimit)
	c:RegisterEffect(e4)
	--Pos Change
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_FIELD)
	e5:SetCode(EFFECT_SET_POSITION)
	e5:SetRange(LOCATION_MZONE)
	e5:SetTarget(c86240887.target)
	e5:SetTargetRange(0,LOCATION_MZONE)
	e5:SetValue(POS_FACEUP_DEFENSE)
	c:RegisterEffect(e5)
	--Prevent Activation
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_FIELD)
	e6:SetRange(LOCATION_MZONE)
	e6:SetCode(EFFECT_CANNOT_ACTIVATE)
	e6:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e6:SetTargetRange(0,1)
	e6:SetValue(c86240887.aclimit)
	c:RegisterEffect(e6)
	--pierce
	local e7=Effect.CreateEffect(c)
	e7:SetType(EFFECT_TYPE_SINGLE)
	e7:SetCode(EFFECT_PIERCE)
	c:RegisterEffect(e7)
end
function c86240887.destruction_swordsman_fusion_check(tp,sg,fc)
	return aux.gffcheck(sg,Card.IsFusionCode,78193831,Card.IsRace,RACE_DRAGON)
end
function c86240887.val(e,c)
	return Duel.GetMatchingGroupCount(c86240887.filter,c:GetControler(),0,LOCATION_GRAVE+LOCATION_MZONE,nil)*1000
end
function c86240887.filter(c)
	return c:IsRace(RACE_DRAGON) and (c:IsLocation(LOCATION_GRAVE) or c:IsFaceup())
end
function c86240887.target(e,c)
	return c:IsRace(RACE_DRAGON)
end
function c86240887.aclimit(e,re,tp)
	return re:GetHandler():IsRace(RACE_DRAGON) and re:IsActiveType(TYPE_MONSTER)
end
