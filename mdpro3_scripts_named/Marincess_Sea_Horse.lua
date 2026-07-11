--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:45
-- Source DB: cards.cdb
-- Card: Marincess Sea Horse  (ID: 36492575)
-- Type: Monster / Effect
-- Attribute: WATER
-- Race: Cyberse
-- Level: 3
-- ATK 1400 | DEF 1000
-- Setcode: 0x12b
-- Scope: OCG / TCG
--
-- Effect Text:
-- You can Special Summon this card (from your hand) to your zone a "Marincess" Link Monster points to.
-- You can only Special Summon "Marincess Sea Horse" once per turn this way.
-- During your Main Phase, except the turn this card was sent to the GY: You can banish this card from
-- your GY; Special Summon 1 WATER monster from your hand to your zone a "Marincess" Link Monster
-- points to.
-- You can only use this effect of "Marincess Sea Horse" once per turn.
--[[ __CARD_HEADER_END__ ]]

--海晶乙女シーホース
function c36492575.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(36492575,0))
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,36492575+EFFECT_COUNT_CODE_OATH)
	e1:SetCondition(c36492575.spcon)
	e1:SetValue(c36492575.spval)
	c:RegisterEffect(e1)
	--tohand
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(36492575,1))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCountLimit(1,36492576)
	e2:SetCondition(aux.exccon)
	e2:SetCost(aux.bfgcost)
	e2:SetTarget(c36492575.sptg)
	e2:SetOperation(c36492575.spop)
	c:RegisterEffect(e2)
end
function c36492575.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x12b) and c:IsType(TYPE_LINK)
end
function c36492575.checkzone(tp)
	local zone=0
	local g=Duel.GetMatchingGroup(c36492575.cfilter,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	for tc in aux.Next(g) do
		zone=bit.bor(zone,tc:GetLinkedZone(tp))
	end
	return bit.band(zone,0x1f)
end
function c36492575.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	local zone=c36492575.checkzone(tp)
	return Duel.GetLocationCount(tp,LOCATION_MZONE,tp,LOCATION_REASON_TOFIELD,zone)>0
end
function c36492575.spval(e,c)
	local tp=c:GetControler()
	local zone=c36492575.checkzone(tp)
	return 0,zone
end
function c36492575.spfilter(c,e,tp,zone)
	return c:IsAttribute(ATTRIBUTE_WATER) and c:IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEUP,tp,zone)
end
function c36492575.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local zone=c36492575.checkzone(tp)
	if chk==0 then return zone~=0
		and Duel.IsExistingMatchingCard(c36492575.spfilter,tp,LOCATION_HAND,0,1,nil,e,tp,zone) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND)
end
function c36492575.spop(e,tp,eg,ep,ev,re,r,rp)
	local zone=c36492575.checkzone(tp)
	if zone==0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c36492575.spfilter,tp,LOCATION_HAND,0,1,1,nil,e,tp,zone)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP,zone)
	end
end
