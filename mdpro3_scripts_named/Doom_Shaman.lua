--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:53
-- Source DB: cards.cdb
-- Card: Doom Shaman  (ID: 94944637)
-- Type: Monster / Effect / Gemini
-- Attribute: DARK
-- Race: Spellcaster
-- Level: 6
-- ATK 2400 | DEF 2000
-- Scope: OCG / TCG
--
-- Effect Text:
-- This card is treated as a Normal Monster while face-up on the field or in the Graveyard.
-- While this card is a Normal Monster on the field, you can Normal Summon it to have it become an
-- Effect Monster with this effect.
-- ● Once per turn: You can Special Summon 1 Fiend-Type monster from your hand or from either
-- Graveyard.
-- When this card leaves the field, destroy all Fiend-Type monsters Special Summoned by this effect.
--[[ __CARD_HEADER_END__ ]]

--魔族召喚師
function c94944637.initial_effect(c)
	aux.EnableDualAttribute(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetDescription(aux.Stringid(94944637,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCondition(aux.IsDualState)
	e1:SetTarget(c94944637.target)
	e1:SetOperation(c94944637.operation)
	c:RegisterEffect(e1)
	--destroy
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_LEAVE_FIELD)
	e2:SetOperation(c94944637.desop)
	c:RegisterEffect(e2)
end
function c94944637.filter(c,e,tp)
	return c:IsRace(RACE_FIEND) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c94944637.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c94944637.filter,tp,LOCATION_GRAVE+LOCATION_HAND,LOCATION_GRAVE,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_GRAVE+LOCATION_HAND)
end
function c94944637.operation(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,aux.NecroValleyFilter(c94944637.filter),tp,LOCATION_GRAVE+LOCATION_HAND,LOCATION_GRAVE,1,1,nil,e,tp)
	local c=e:GetHandler()
	local tc=g:GetFirst()
	if tc then
		if Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)==0 then return end
		if c:IsFaceup() and c:IsRelateToEffect(e) then c:SetCardTarget(tc) end
	end
end
function c94944637.desfilter(c,rc)
	return rc:GetCardTarget():IsContains(c) and c:IsRace(RACE_FIEND)
end
function c94944637.desop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:GetCardTargetCount()>0 then
		local dg=Duel.GetMatchingGroup(c94944637.desfilter,tp,LOCATION_MZONE,LOCATION_MZONE,nil,c)
		Duel.Destroy(dg,REASON_EFFECT)
	end
end
