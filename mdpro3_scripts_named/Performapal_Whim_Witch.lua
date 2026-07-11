--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:50
-- Source DB: cards.cdb
-- Card: Performapal Whim Witch  (ID: 64450427)
-- Type: Monster / Effect / Pendulum
-- Attribute: DARK
-- Race: Spellcaster
-- Level: 3
-- ATK 800 | DEF 800
-- Pendulum Scale: L4 / R4
-- Setcode: 0x9f
-- Scope: OCG / TCG
--
-- Effect Text:
-- Pendulum Scale = 4
-- [ Pendulum Effect ]
-- If your opponent controls a face-up monster that was Special Summoned from the Extra Deck and you do
-- not: You can Special Summon this card from your Pendulum Zone.
-- You can only use this effect of "Performapal Whim Witch" once per turn.
-- ----------------------------------------
-- [ Monster Effect ]
-- This card can be treated as 2 Tributes for the Tribute Summon of a Pendulum Monster.
--[[ __CARD_HEADER_END__ ]]

--EMウィム・ウィッチ
function c64450427.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(64450427,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_PZONE)
	e1:SetCountLimit(1,64450427)
	e1:SetCondition(c64450427.spcon)
	e1:SetTarget(c64450427.sptg)
	e1:SetOperation(c64450427.spop)
	c:RegisterEffect(e1)
	--double tribute
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_DOUBLE_TRIBUTE)
	e2:SetValue(c64450427.dtcon)
	c:RegisterEffect(e2)
end
function c64450427.cfilter(c)
	return c:IsSummonLocation(LOCATION_EXTRA)
end
function c64450427.spcon(e,tp,eg,ep,ev,re,r,rp)
	return not Duel.IsExistingMatchingCard(c64450427.cfilter,tp,LOCATION_MZONE,0,1,nil)
		and Duel.IsExistingMatchingCard(c64450427.cfilter,tp,0,LOCATION_MZONE,1,nil)
end
function c64450427.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c64450427.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
end
function c64450427.dtcon(e,c)
	return c:IsType(TYPE_PENDULUM)
end
