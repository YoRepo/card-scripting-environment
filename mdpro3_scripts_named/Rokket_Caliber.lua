--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:51
-- Source DB: cards.cdb
-- Card: Rokket Caliber  (ID: 67127799)
-- Type: Monster / Effect / Tuner
-- Attribute: DARK
-- Race: Dragon
-- Level: 4
-- ATK 1700 | DEF 100
-- Setcode: 0x102
-- Scope: OCG / TCG
--
-- Effect Text:
-- You can Special Summon this card (from your hand) to your zone a DARK Link Monster points to.
-- You can only Special Summon "Rokket Caliber" once per turn this way.
-- You can Tribute this card; Special Summon 1 DARK Dragon or Machine monster from your hand, except
-- "Rokket Caliber".
-- You can only use this effect of "Rokket Caliber" once per turn.
--[[ __CARD_HEADER_END__ ]]

--ヴァレット・キャリバー
function c67127799.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,67127799+EFFECT_COUNT_CODE_OATH)
	e1:SetCondition(c67127799.spcon)
	e1:SetValue(c67127799.spval)
	c:RegisterEffect(e1)
	--spsummon 2
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(67127799,0))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1,67127800)
	e2:SetCost(c67127799.spcost2)
	e2:SetTarget(c67127799.sptg2)
	e2:SetOperation(c67127799.spop2)
	c:RegisterEffect(e2)
end
function c67127799.linkedfilter(c)
	return c:IsFaceup() and c:IsAttribute(ATTRIBUTE_DARK) and c:IsType(TYPE_LINK)
end
function c67127799.checkzone(tp)
	local zone=0
	local g=Duel.GetMatchingGroup(c67127799.linkedfilter,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	for tc in aux.Next(g) do
		zone=bit.bor(zone,tc:GetLinkedZone(tp))
	end
	return bit.band(zone,0x1f)
end
function c67127799.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	local zone=c67127799.checkzone(tp)
	return Duel.GetLocationCount(tp,LOCATION_MZONE,tp,LOCATION_REASON_TOFIELD,zone)>0
end
function c67127799.spval(e,c)
	local tp=c:GetControler()
	local zone=c67127799.checkzone(tp)
	return 0,zone
end
function c67127799.spcost2(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:IsReleasable() end
	Duel.Release(c,REASON_COST)
end
function c67127799.spfilter(c,e,tp)
	return c:IsAttribute(ATTRIBUTE_DARK) and c:IsRace(RACE_DRAGON+RACE_MACHINE)
		and not c:IsCode(67127799) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c67127799.sptg2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetMZoneCount(tp,e:GetHandler())>0
		and Duel.IsExistingMatchingCard(c67127799.spfilter,tp,LOCATION_HAND,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND)
end
function c67127799.spop2(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<1 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c67127799.spfilter,tp,LOCATION_HAND,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
