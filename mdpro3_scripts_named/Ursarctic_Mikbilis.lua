--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:52
-- Source DB: cards.cdb
-- Card: Ursarctic Mikbilis  (ID: 81321206)
-- Type: Monster / Effect
-- Attribute: WATER
-- Race: Beast
-- Level: 7
-- ATK 700 | DEF 1400
-- Setcode: 0x163
-- Scope: OCG / TCG
--
-- Effect Text:
-- During the Main Phase (Quick Effect): You can Tribute 1 other Level 7 or higher monster from your
-- hand; Special Summon this card from your hand, also you cannot Special Summon for the rest of this
-- turn, except monsters with a Level.
-- If this card is Special Summoned: You can Special Summon 1 "Ursarctic" monster from your hand,
-- except "Ursarctic Mikbilis".
-- You can only use each effect of "Ursarctic Mikbilis" once per turn.
--[[ __CARD_HEADER_END__ ]]

--ベアルクティ－ミクビリス
function c81321206.initial_effect(c)
	--spsummon
	local e1=aux.AddUrsarcticSpSummonEffect(c)
	e1:SetDescription(aux.Stringid(81321206,0))
	e1:SetCountLimit(1,81321206)
	--spsummon2
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(81321206,1))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetProperty(EFFECT_FLAG_DELAY)
	e2:SetCountLimit(1,81321207)
	e2:SetTarget(c81321206.sptg2)
	e2:SetOperation(c81321206.spop2)
	c:RegisterEffect(e2)
end
function c81321206.spfilter2(c,e,tp)
	return c:IsSetCard(0x163) and not c:IsCode(81321206) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c81321206.sptg2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and Duel.IsExistingMatchingCard(c81321206.spfilter2,tp,LOCATION_HAND,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND)
end
function c81321206.spop2(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c81321206.spfilter2,tp,LOCATION_HAND,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
