--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:43
-- Source DB: cards.cdb
-- Card: Odd-Eyes Arc Pendulum Dragon  (ID: 14105623)
-- Type: Monster / Normal / Pendulum
-- Attribute: DARK
-- Race: Dragon
-- Level: 7
-- ATK 2700 | DEF 2000
-- Pendulum Scale: L8 / R8
-- Setcode: 0x99, 0x10f2
-- Scope: OCG / TCG
--
-- Effect Text:
-- Pendulum Scale = 8
-- [ Pendulum Effect ]
-- If an "Odd-Eyes" card(s) you control is destroyed by battle or card effect: You can Special Summon 1
-- "Odd-Eyes" monster from your hand, Deck, or GY. You can only use this effect of "Odd-Eyes Arc
-- Pendulum Dragon" once per turn.
-- ----------------------------------------
-- [ Monster Effect ]
-- Made from miracles, this valiant and beautiful dragon has gleaming eyes that reflect an arc drawn in
-- the sky.
--[[ __CARD_HEADER_END__ ]]

--オッドアイズ・アークペンデュラム・ドラゴン
function c14105623.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(14105623,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e1:SetCode(EVENT_DESTROYED)
	e1:SetRange(LOCATION_PZONE)
	e1:SetCountLimit(1,14105623)
	e1:SetCondition(c14105623.spcon)
	e1:SetTarget(c14105623.sptg)
	e1:SetOperation(c14105623.spop)
	c:RegisterEffect(e1)
end
function c14105623.cfilter(c,tp)
	return c:IsReason(REASON_BATTLE+REASON_EFFECT) and c:IsPreviousSetCard(0x99)
		and c:IsPreviousControler(tp) and c:IsPreviousLocation(LOCATION_ONFIELD) and c:IsPreviousPosition(POS_FACEUP)
end
function c14105623.spcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c14105623.cfilter,1,nil,tp)
end
function c14105623.spfilter(c,e,tp)
	return c:IsSetCard(0x99) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c14105623.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c14105623.spfilter,tp,LOCATION_HAND+LOCATION_DECK+LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND+LOCATION_DECK+LOCATION_GRAVE)
end
function c14105623.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 or not e:GetHandler():IsRelateToEffect(e) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,aux.NecroValleyFilter(c14105623.spfilter),tp,LOCATION_HAND+LOCATION_DECK+LOCATION_GRAVE,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
