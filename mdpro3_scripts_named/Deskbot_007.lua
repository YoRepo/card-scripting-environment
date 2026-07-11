--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:54
-- Source DB: cards.cdb
-- Card: Deskbot 007  (ID: 97588916)
-- Type: Monster / Effect / Pendulum
-- Attribute: EARTH
-- Race: Machine
-- Level: 7
-- ATK 500 | DEF 500
-- Pendulum Scale: L10 / R10
-- Setcode: 0xab
-- Scope: OCG / TCG
--
-- Effect Text:
-- Pendulum Scale = 10
-- [ Pendulum Effect ]
-- You cannot Pendulum Summon monsters, except "Deskbot" monsters.
-- This effect cannot be negated.
-- ----------------------------------------
-- [ Monster Effect ]
-- This card gains 500 ATK for each "Deskbot" card in your Graveyard.
-- Monsters your opponent controls cannot target face-up "Deskbot" monsters for attacks, except this
-- one.
-- If this card attacks a Defense Position monster, inflict piercing battle damage to your opponent.
--[[ __CARD_HEADER_END__ ]]

--ブンボーグ007
function c97588916.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c)
	--splimit
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetRange(LOCATION_PZONE)
	e2:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_CANNOT_DISABLE)
	e2:SetTargetRange(1,0)
	e2:SetCondition(c97588916.splimcon)
	e2:SetTarget(c97588916.splimit)
	c:RegisterEffect(e2)
	--
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCode(EFFECT_UPDATE_ATTACK)
	e3:SetValue(c97588916.value)
	c:RegisterEffect(e3)
	--pierce
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_SINGLE)
	e5:SetCode(EFFECT_PIERCE)
	c:RegisterEffect(e5)
	--
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_FIELD)
	e6:SetRange(LOCATION_MZONE)
	e6:SetTargetRange(0,LOCATION_MZONE)
	e6:SetCode(EFFECT_CANNOT_SELECT_BATTLE_TARGET)
	e6:SetValue(c97588916.atlimit)
	c:RegisterEffect(e6)
end
function c97588916.splimcon(e)
	return not e:GetHandler():IsForbidden()
end
function c97588916.splimit(e,c,tp,sumtp,sumpos)
	return not c:IsSetCard(0xab) and bit.band(sumtp,SUMMON_TYPE_PENDULUM)==SUMMON_TYPE_PENDULUM
end
function c97588916.value(e,c)
	return Duel.GetMatchingGroupCount(Card.IsSetCard,c:GetControler(),LOCATION_GRAVE,0,nil,0xab)*500
end
function c97588916.atlimit(e,c)
	return c:IsFaceup() and c:IsSetCard(0xab) and c~=e:GetHandler()
end
