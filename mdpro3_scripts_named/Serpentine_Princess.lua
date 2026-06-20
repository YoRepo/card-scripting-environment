--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 纳迦  (ID: 71829750)
-- Type: Monster / Effect
-- Attribute: WATER
-- Race: Reptile
-- Level 4
-- ATK 1400 | DEF 2000
--
-- Effect Text:
-- ①：表侧表示的这张卡从场上回到卡组的场合发动。从卡组把1只3星以下的怪兽特殊召唤。
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
