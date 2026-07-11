--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:47
-- Source DB: cards.cdb
-- Card: Nova Summoner  (ID: 48783998)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Fairy
-- Level: 4
-- ATK 1400 | DEF 800
-- Scope: OCG / TCG
--
-- Effect Text:
-- When this card is destroyed by battle and sent to the GY: You can Special Summon 1 LIGHT Fairy
-- monster with 1500 or less ATK from your Deck.
-- If "The Sanctuary in the Sky" is on the field, you can Special Summon 1 "Airknight Parshath"
-- instead.
--[[ __CARD_HEADER_END__ ]]

--コーリング・ノヴァ
function c48783998.initial_effect(c)
	aux.AddCodeList(c,56433456)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(48783998,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_BATTLE_DESTROYED)
	e1:SetCondition(c48783998.condition)
	e1:SetTarget(c48783998.target)
	e1:SetOperation(c48783998.operation)
	c:RegisterEffect(e1)
end
function c48783998.condition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsLocation(LOCATION_GRAVE) and e:GetHandler():IsReason(REASON_BATTLE)
end
function c48783998.filter1(c,e,tp)
	return c:IsAttackBelow(1500) and c:IsAttribute(ATTRIBUTE_LIGHT) and c:IsRace(RACE_FAIRY)
		and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c48783998.filter2(c,e,tp)
	return (c:IsCode(18036057) or (c:IsAttackBelow(1500) and c:IsAttribute(ATTRIBUTE_LIGHT) and c:IsRace(RACE_FAIRY)))
		and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c48783998.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return false end
		if not Duel.IsEnvironment(56433456) then
			return Duel.IsExistingMatchingCard(c48783998.filter1,tp,LOCATION_DECK,0,1,nil,e,tp)
		else
			return Duel.IsExistingMatchingCard(c48783998.filter2,tp,LOCATION_DECK,0,1,nil,e,tp)
		end
	end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c48783998.operation(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	local g=nil
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	if not Duel.IsEnvironment(56433456) then
		g=Duel.SelectMatchingCard(tp,c48783998.filter1,tp,LOCATION_DECK,0,1,1,nil,e,tp)
	else
		g=Duel.SelectMatchingCard(tp,c48783998.filter2,tp,LOCATION_DECK,0,1,1,nil,e,tp)
	end
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
