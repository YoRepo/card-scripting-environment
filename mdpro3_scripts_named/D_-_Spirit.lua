--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:53
-- Source DB: cards.cdb
-- Card: D - Spirit  (ID: 89899996)
-- Type: Spell
-- Scope: OCG / TCG
--
-- Effect Text:
-- Special Summon 1 Level 4 or lower "Destiny HERO" monster from your hand.
-- You must not control any "Destiny HERO" monsters to activate and to resolve this effect.
--[[ __CARD_HEADER_END__ ]]

--D－スピリッツ
function c89899996.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c89899996.target)
	e1:SetOperation(c89899996.operation)
	c:RegisterEffect(e1)
end
function c89899996.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0xc008)
end
function c89899996.spfilter(c,e,tp)
	return c:IsLevelBelow(4) and c:IsSetCard(0xc008) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c89899996.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c89899996.spfilter,tp,LOCATION_HAND,0,1,nil,e,tp)
		and not Duel.IsExistingMatchingCard(c89899996.cfilter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND)
end
function c89899996.operation(e,tp,eg,ep,ev,re,r,rp)
	if Duel.IsExistingMatchingCard(c89899996.cfilter,tp,LOCATION_MZONE,0,1,nil)
		or Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c89899996.spfilter,tp,LOCATION_HAND,0,1,1,nil,e,tp)
	if g:GetCount()~=0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
