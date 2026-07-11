--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:42
-- Source DB: cards.cdb
-- Card: Symphonic Warrior Guitaar  (ID: 12525049)
-- Type: Monster / Effect / Pendulum
-- Attribute: WIND
-- Race: Machine
-- Level: 3
-- ATK 1500 | DEF 100
-- Pendulum Scale: L7 / R7
-- Setcode: 0x1066
-- Scope: OCG / TCG
--
-- Effect Text:
-- Pendulum Scale = 7
-- [ Pendulum Effect ]
-- You can discard 1 card; Special Summon 1 "Symphonic Warrior" monster from your Deck, except
-- "Symphonic Warrior Guitaar".
-- You can only use this effect of "Symphonic Warrior Guitaar" once per turn.
-- ----------------------------------------
-- [ Monster Effect ]
-- When this card is Normal Summoned: You can target 1 "Symphonic Warrior" monster in your Graveyard;
-- Special Summon it.
--[[ __CARD_HEADER_END__ ]]

--音響戦士ギータス
function c12525049.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c)
	--spsummon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(12525049,0))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_PZONE)
	e2:SetCountLimit(1,12525049)
	e2:SetCost(c12525049.spcost)
	e2:SetTarget(c12525049.sptg)
	e2:SetOperation(c12525049.spop)
	c:RegisterEffect(e2)
	--spsummon
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(12525049,1))
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_SUMMON_SUCCESS)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DAMAGE_STEP)
	e3:SetTarget(c12525049.target)
	e3:SetOperation(c12525049.operation)
	c:RegisterEffect(e3)
end
function c12525049.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsDiscardable,tp,LOCATION_HAND,0,1,nil) end
	Duel.DiscardHand(tp,Card.IsDiscardable,1,1,REASON_COST+REASON_DISCARD)
end
function c12525049.spfilter(c,e,tp)
	return c:IsSetCard(0x1066) and not c:IsCode(12525049) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c12525049.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c12525049.spfilter,tp,LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c12525049.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c12525049.spfilter,tp,LOCATION_DECK,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
function c12525049.filter(c,e,tp)
	return c:IsSetCard(0x1066) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c12525049.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c12525049.filter(chkc,e,tp) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingTarget(c12525049.filter,tp,LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c12525049.filter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function c12525049.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
	end
end
