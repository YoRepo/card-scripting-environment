--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:52
-- Source DB: cards.cdb
-- Card: Artillery Catapult Turtle  (ID: 7913375)
-- Type: Monster / Effect
-- Attribute: WATER
-- Race: Aqua
-- Level: 4
-- ATK 1000 | DEF 2000
-- Scope: OCG / TCG
--
-- Effect Text:
-- You can Tribute 1 monster; Special Summon 1 "Gaia The Fierce Knight" monster, or 1 Level 5 Dragon
-- monster, from your hand or Deck.
-- You can only use this effect of "Artillery Catapult Turtle" once per turn.
--[[ __CARD_HEADER_END__ ]]

--砲撃のカタパルト・タートル
function c7913375.initial_effect(c)
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(7913375,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1,7913375)
	e1:SetCost(c7913375.spcost)
	e1:SetTarget(c7913375.sptg)
	e1:SetOperation(c7913375.spop)
	c:RegisterEffect(e1)
end
function c7913375.rfilter(c,tp)
	return Duel.GetMZoneCount(tp,c)>0
end
function c7913375.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckReleaseGroup(tp,c7913375.rfilter,1,nil,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RELEASE)
	local g=Duel.SelectReleaseGroup(tp,c7913375.rfilter,1,1,nil,tp)
	Duel.Release(g,REASON_COST)
end
function c7913375.spfilter(c,e,tp)
	return (c:IsSetCard(0xbd) or c:IsLevel(5) and c:IsRace(RACE_DRAGON)) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c7913375.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c7913375.spfilter,tp,LOCATION_HAND+LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND+LOCATION_DECK)
end
function c7913375.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c7913375.spfilter,tp,LOCATION_HAND+LOCATION_DECK,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
