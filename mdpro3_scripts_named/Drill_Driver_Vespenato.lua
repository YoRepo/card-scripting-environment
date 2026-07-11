--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:45
-- Source DB: cards.cdb
-- Card: Drill Driver Vespenato  (ID: 39317553)
-- Type: Monster / Effect / Xyz
-- Attribute: EARTH
-- Race: Machine
-- Rank: 5
-- ATK 2500 | DEF 2100
-- Scope: OCG / TCG
--
-- Effect Text:
-- 2 Level 5 monsters
-- Once per turn, you can also Xyz Summon "Drill Driver Vespenato" by using 1 Rank 4 Xyz Monster you
-- control as material.
-- (Transfer its materials to this card.)
-- Cannot be used as material for an Xyz Summon the turn it was Xyz Summoned.
-- If this card attacks a Defense Position monster, inflict piercing battle damage to your opponent.
-- If this Xyz Summoned card in its owner's control is destroyed by an opponent's card: You can target
-- 1 Level 5 or lower monster in your GY; Special Summon it.
-- You can only use this effect of "Drill Driver Vespenato" once per turn.
--[[ __CARD_HEADER_END__ ]]

--旋壊のヴェスペネイト
function c39317553.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,nil,5,2,c39317553.ovfilter,aux.Stringid(39317553,0),2,c39317553.xyzop)
	c:EnableReviveLimit()
	--can not be xyz material
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_CANNOT_BE_XYZ_MATERIAL)
	e1:SetCondition(c39317553.xyzcon)
	e1:SetValue(1)
	c:RegisterEffect(e1)
	--pierce
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_PIERCE)
	c:RegisterEffect(e2)
	--SpecialSummon
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(39317553,1))
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetProperty(EFFECT_FLAG_DELAY+EFFECT_FLAG_CARD_TARGET)
	e3:SetCode(EVENT_DESTROYED)
	e3:SetCountLimit(1,39317553)
	e3:SetCondition(c39317553.spcon)
	e3:SetTarget(c39317553.sptg)
	e3:SetOperation(c39317553.spop)
	c:RegisterEffect(e3)
end
function c39317553.ovfilter(c)
	return c:IsFaceup() and c:IsRank(4)
end
function c39317553.xyzop(e,tp,chk)
	if chk==0 then return Duel.GetFlagEffect(tp,39317553)==0 end
	Duel.RegisterFlagEffect(tp,39317553,RESET_PHASE+PHASE_END,EFFECT_FLAG_OATH,1)
end
function c39317553.xyzcon(e)
	local c=e:GetHandler()
	return c:IsStatus(STATUS_SPSUMMON_TURN) and c:IsSummonType(SUMMON_TYPE_XYZ)
end
function c39317553.spcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return rp==1-tp and c:IsPreviousControler(tp) and c:IsPreviousLocation(LOCATION_MZONE) and c:IsSummonType(SUMMON_TYPE_XYZ)
end
function c39317553.spfilter(c,e,tp)
	return c:IsLevelBelow(5) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c39317553.sptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c39317553.spfilter(chkc,e,tp) end
	if chk==0 then return Duel.GetMZoneCount(tp)>0
		and Duel.IsExistingTarget(c39317553.spfilter,tp,LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c39317553.spfilter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,tp,LOCATION_GRAVE)
end
function c39317553.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetMZoneCount(tp)<1 then return end
	local c=Duel.GetFirstTarget()
	if c and c:IsRelateToEffect(e) then
		Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
	end
end
