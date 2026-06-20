--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:24
-- Card: 三幻魔的操世者  (ID: 22734799)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Thunder
-- Level 8
-- ATK 2300 | DEF 3000
-- Setcode: 4420
--
-- Effect Text:
-- 这个卡名的①②③的效果1回合各能使用1次。
-- ①：把手卡的这张卡给对方观看才能发动。选自己1张手卡丢弃，从手卡把1只8星以外的「三幻魔」怪兽守备表示特殊召唤。
-- ②：丢弃1张手卡才能发动。除丢弃的卡外的1只8星以外的「三幻魔」怪兽从自己的手卡·墓地守备表示特殊召唤。
-- ③：把墓地的这张卡除外才能发动。从自己墓地把1只8星以外的「三幻魔」怪兽守备表示特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--三幻魔の操世者
local s,id,o=GetID()
function s.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(id,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_HANDES)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,id)
	e1:SetCost(s.spcost)
	e1:SetTarget(s.sptg)
	e1:SetOperation(s.spop)
	c:RegisterEffect(e1)
	--special summon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(id,1))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1,id+o)
	e2:SetCost(s.spcost2)
	e2:SetTarget(s.sptg2)
	e2:SetOperation(s.spop2)
	c:RegisterEffect(e2)
	--special summon
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(id,2))
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_GRAVE)
	e3:SetCountLimit(1,id+o*2)
	e3:SetCost(aux.bfgcost)
	e3:SetTarget(s.sptg3)
	e3:SetOperation(s.spop3)
	c:RegisterEffect(e3)
end
function s.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return not e:GetHandler():IsPublic() end
end
function s.hfilter(c,e,tp)
	return c:IsDiscardable(REASON_EFFECT+REASON_DISCARD)
		and Duel.IsExistingMatchingCard(s.spfilter,tp,LOCATION_HAND,0,1,c,e,tp)
end
function s.spfilter(c,e,tp)
	if not c:IsSetCard(0x1144) or c:IsLevel(8) then return false end
	return c:IsCanBeSpecialSummoned(e,0,tp,false,aux.PhantasmsSpSummonType(c),POS_FACEUP_DEFENSE)
end
function s.spsummon(c,tp)
	local flag=aux.PhantasmsSpSummonType(c)
	if Duel.SpecialSummon(c,0,tp,tp,false,flag,POS_FACEUP_DEFENSE) and flag then
		c:CompleteProcedure()
	end
end
function s.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(s.hfilter,tp,LOCATION_HAND,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND)
	Duel.SetOperationInfo(0,CATEGORY_HANDES,nil,0,tp,1)
end
function s.spop(e,tp,eg,ep,ev,re,r,rp)
	local dres=0
	if not Duel.IsExistingMatchingCard(s.hfilter,tp,LOCATION_HAND,0,1,nil,e,tp) then
		dres=Duel.DiscardHand(tp,nil,1,1,REASON_EFFECT+REASON_DISCARD)
	else
		dres=Duel.DiscardHand(tp,s.hfilter,1,1,REASON_EFFECT+REASON_DISCARD,nil,e,tp)
	end
	if dres>0 then
		if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local g=Duel.SelectMatchingCard(tp,s.spfilter,tp,LOCATION_HAND,0,1,1,nil,e,tp)
		local tc=g:GetFirst()
		if tc then
			s.spsummon(tc,tp)
		end
	else
		Duel.DiscardHand(tp,nil,1,1,REASON_EFFECT+REASON_DISCARD)
	end
end
function s.hfilter2(c,e,tp)
	return c:IsDiscardable()
		and Duel.IsExistingMatchingCard(s.spfilter,tp,LOCATION_HAND+LOCATION_GRAVE,0,1,c,e,tp)
end
function s.spcost2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(s.hfilter2,tp,LOCATION_HAND,0,1,nil,e,tp) end
	Duel.DiscardHand(tp,s.hfilter2,1,1,REASON_COST+REASON_DISCARD,nil,e,tp)
	local og=Duel.GetOperatedGroup()
	Duel.SetTargetCard(og)
end
function s.sptg2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(s.spfilter,tp,LOCATION_HAND+LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND+LOCATION_GRAVE)
end
function s.spop2(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	local tc=Duel.GetFirstTarget()
	if not tc:IsRelateToChain() then tc=nil end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,aux.NecroValleyFilter(s.spfilter),tp,LOCATION_HAND+LOCATION_GRAVE,0,1,1,tc,e,tp)
	local sc=g:GetFirst()
	if sc then
		s.spsummon(sc,tp)
	end
end
function s.sptg3(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(s.spfilter,tp,LOCATION_GRAVE,0,1,e:GetHandler(),e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_GRAVE)
end
function s.spop3(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,aux.NecroValleyFilter(s.spfilter),tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
	local tc=g:GetFirst()
	if tc then
		s.spsummon(tc,tp)
	end
end
