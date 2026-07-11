--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:51
-- Source DB: cards.cdb
-- Card: Serpentine Princess  (ID: 71829750)
-- Type: Monster / Effect
-- Attribute: WATER
-- Race: Reptile
-- Level: 4
-- ATK 1400 | DEF 2000
-- Scope: OCG / TCG
--
-- Effect Text:
-- If this face-up card is shuffled from the field into your Deck: Special Summon 1 Level 3 or lower
-- monster from your Deck.
--[[ __CARD_HEADER_END__ ]]

--ナーガ
function c71829750.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(71829750,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_TO_DECK)
	e1:SetCondition(c71829750.spcon)
	e1:SetTarget(c71829750.sptg)
	e1:SetOperation(c71829750.spop)
	c:RegisterEffect(e1)
end
function c71829750.spcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsPreviousPosition(POS_FACEUP)
		and e:GetHandler():IsPreviousLocation(LOCATION_ONFIELD)
end
function c71829750.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c71829750.spfilter(c,e,tp)
	return c:IsLevelBelow(3) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c71829750.spop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c71829750.spfilter,tp,LOCATION_DECK,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
