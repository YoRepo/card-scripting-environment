--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:52
-- Source DB: cards.cdb
-- Card: Sea Dragoons of Draconia  (ID: 82114013)
-- Type: Monster / Normal / Pendulum
-- Attribute: WATER
-- Race: Sea Serpent
-- Level: 3
-- ATK 200 | DEF 2100
-- Pendulum Scale: L7 / R7
-- Scope: OCG / TCG
--
-- Effect Text:
-- Pendulum Scale = 7
-- [ Pendulum Effect ]
-- When a monster is destroyed by battle: You can Special Summon 1 Normal Monster from your hand. You
-- can only use this effect of "Sea Dragoons of Draconia" once per turn.
-- ----------------------------------------
-- [ Monster Effect ]
-- Silently creeping in from the deep sea, elite black ops marine troops of the Draconia Empire wage an
-- endless battle against the hated Principality of Dinon on the sea's opposite shores.
--[[ __CARD_HEADER_END__ ]]

--ドラコニアの海竜騎兵
function c82114013.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c)
	--spsummon
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_BATTLE_DESTROYED)
	e2:SetRange(LOCATION_PZONE)
	e2:SetCountLimit(1,82114013)
	e2:SetTarget(c82114013.sptg)
	e2:SetOperation(c82114013.spop)
	c:RegisterEffect(e2)
end
function c82114013.spfilter(c,e,tp)
	return c:IsType(TYPE_NORMAL) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c82114013.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c82114013.spfilter,tp,LOCATION_HAND,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND)
end
function c82114013.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c82114013.spfilter,tp,LOCATION_HAND,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
