--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:46
-- Source DB: cards.cdb
-- Card: Chrysalis Pantail  (ID: 43751755)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Beast
-- Level: 2
-- ATK 800 | DEF 300
-- Setcode: 0x1e
-- Scope: OCG / TCG
--
-- Effect Text:
-- You can Tribute this card while "Neo Space" is on the field to Special Summon 1 "Neo-Spacian Dark
-- Panther" from your hand or Deck.
--[[ __CARD_HEADER_END__ ]]

--C・パンテール
function c43751755.initial_effect(c)
	aux.AddCodeList(c,43237273)
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(43751755,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(c43751755.spcon)
	e1:SetCost(c43751755.spcost)
	e1:SetTarget(c43751755.sptg)
	e1:SetOperation(c43751755.spop)
	c:RegisterEffect(e1)
end
function c43751755.spcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsEnvironment(42015635)
end
function c43751755.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsReleasable() end
	Duel.Release(e:GetHandler(),REASON_COST)
end
function c43751755.spfilter(c,e,tp)
	return c:IsCode(43237273) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c43751755.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>-1
		and Duel.IsExistingMatchingCard(c43751755.spfilter,tp,LOCATION_HAND+LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND+LOCATION_DECK)
end
function c43751755.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	if not Duel.IsEnvironment(42015635) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c43751755.spfilter,tp,LOCATION_HAND+LOCATION_DECK,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
