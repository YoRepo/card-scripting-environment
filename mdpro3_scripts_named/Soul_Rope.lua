--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:45
-- Source DB: cards.cdb
-- Card: Soul Rope  (ID: 37383714)
-- Type: Trap
-- Scope: OCG / TCG
--
-- Effect Text:
-- When a monster you control is destroyed by a card effect and sent to the Graveyard (except during
-- the Damage Step): Pay 1000 LP; Special Summon 1 Level 4 monster from your Deck.
--[[ __CARD_HEADER_END__ ]]

--魂の綱
function c37383714.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_TO_GRAVE)
	e1:SetCondition(c37383714.condition)
	e1:SetCost(c37383714.cost)
	e1:SetTarget(c37383714.target)
	e1:SetOperation(c37383714.activate)
	c:RegisterEffect(e1)
end
function c37383714.cfilter(c,tp)
	return c:IsReason(REASON_EFFECT) and c:IsReason(REASON_DESTROY) and c:IsType(TYPE_MONSTER)
		and c:IsPreviousControler(tp) and c:IsPreviousLocation(LOCATION_MZONE)
end
function c37383714.condition(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c37383714.cfilter,1,nil,tp)
end
function c37383714.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(tp,1000) end
	Duel.PayLPCost(tp,1000)
end
function c37383714.spfilter(c,e,tp)
	return c:IsLevel(4) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c37383714.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c37383714.spfilter,tp,LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c37383714.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c37383714.spfilter,tp,LOCATION_DECK,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
