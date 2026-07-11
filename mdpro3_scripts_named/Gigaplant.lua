--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:48
-- Source DB: cards.cdb
-- Card: Gigaplant  (ID: 53257892)
-- Type: Monster / Effect / Gemini
-- Attribute: EARTH
-- Race: Plant
-- Level: 6
-- ATK 2400 | DEF 1200
-- Scope: OCG / TCG
--
-- Effect Text:
-- This card is treated as a Normal Monster while face-up on the field or in the GY.
-- While this card is a Normal Monster on the field, you can Normal Summon it to have it become an
-- Effect Monster with this effect.
-- ● Once per turn: You can Special Summon 1 Insect or Plant monster from your hand or GY.
--[[ __CARD_HEADER_END__ ]]

--ギガプラント
function c53257892.initial_effect(c)
	aux.EnableDualAttribute(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetDescription(aux.Stringid(53257892,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCondition(aux.IsDualState)
	e1:SetTarget(c53257892.target)
	e1:SetOperation(c53257892.operation)
	c:RegisterEffect(e1)
end
function c53257892.filter(c,e,tp)
	return c:IsRace(RACE_INSECT+RACE_PLANT) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c53257892.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c53257892.filter,tp,LOCATION_GRAVE+LOCATION_HAND,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_GRAVE+LOCATION_HAND)
end
function c53257892.operation(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,aux.NecroValleyFilter(c53257892.filter),tp,LOCATION_GRAVE+LOCATION_HAND,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
