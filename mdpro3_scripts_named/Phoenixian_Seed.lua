--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:53
-- Source DB: cards.cdb
-- Card: Phoenixian Seed  (ID: 96553688)
-- Type: Monster / Effect
-- Attribute: FIRE
-- Race: Plant
-- Level: 2
-- ATK 800 | DEF 0
-- Scope: OCG / TCG
--
-- Effect Text:
-- You can send this face-up card to the Graveyard to Special Summon 1 "Phoenixian Cluster Amaryllis"
-- from your hand.
--[[ __CARD_HEADER_END__ ]]

--フェニキシアン・シード
function c96553688.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(96553688,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCost(c96553688.cost)
	e1:SetTarget(c96553688.target)
	e1:SetOperation(c96553688.operation)
	c:RegisterEffect(e1)
end
function c96553688.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToGraveAsCost() end
	Duel.SendtoGrave(e:GetHandler(),REASON_COST)
end
function c96553688.filter(c,e,tp)
	return c:IsCode(23558733) and c:IsCanBeSpecialSummoned(e,0,tp,true,false)
end
function c96553688.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>-1
		and Duel.IsExistingMatchingCard(c96553688.filter,tp,LOCATION_HAND,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND)
end
function c96553688.operation(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c96553688.filter,tp,LOCATION_HAND,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,true,false,POS_FACEUP)
	end
end
