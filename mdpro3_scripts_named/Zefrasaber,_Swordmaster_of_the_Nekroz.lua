--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:52
-- Source DB: cards.cdb
-- Card: Zefrasaber, Swordmaster of the Nekroz  (ID: 84388461)
-- Type: Monster / Effect / Pendulum
-- Attribute: WATER
-- Race: Spellcaster
-- Level: 4
-- ATK 1500 | DEF 800
-- Pendulum Scale: L1 / R1
-- Setcode: 0xc4, 0xb4, 0xd
-- Scope: OCG / TCG
--
-- Effect Text:
-- Pendulum Scale = 1
-- [ Pendulum Effect ]
-- You cannot Pendulum Summon monsters, except "Nekroz" and "Zefra" monsters.
-- This effect cannot be negated.
-- ----------------------------------------
-- [ Monster Effect ]
-- You can Tribute this card from your hand or face-up from your side of the field; Tribute monsters
-- from your hand or field, then Ritual Summon 1 "Nekroz" Ritual Monster from your hand whose Level
-- exactly equals the total Levels of those monsters.
-- You can only use this effect of "Zefrasaber, Swordmaster of the Nekroz" once per turn.
--[[ __CARD_HEADER_END__ ]]

--剣聖の影霊衣－セフィラセイバー
function c84388461.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c)
	--splimit
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetRange(LOCATION_PZONE)
	e2:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_CAN_FORBIDDEN)
	e2:SetTargetRange(1,0)
	e2:SetTarget(c84388461.splimit)
	c:RegisterEffect(e2)
	--spsummon
	local e3=aux.AddRitualProcEqual2(c,c84388461.filter,nil,nil,c84388461.mfilter,true)
	e3:SetDescription(aux.Stringid(84388461,1))
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetCode(0)
	e3:SetCountLimit(1,84388461)
	e3:SetRange(LOCATION_MZONE+LOCATION_HAND)
	e3:SetCost(c84388461.cost)
	c:RegisterEffect(e3)
end
function c84388461.splimit(e,c,sump,sumtype,sumpos,targetp)
	if c:IsSetCard(0xb4,0xc4) then return false end
	return bit.band(sumtype,SUMMON_TYPE_PENDULUM)==SUMMON_TYPE_PENDULUM
end
function c84388461.filter(c)
	return c:IsSetCard(0xb4)
end
function c84388461.mfilter(c,e,tp,chk)
	return not chk or c~=e:GetHandler()
end
function c84388461.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsReleasable() end
	Duel.Release(e:GetHandler(),REASON_COST)
end
