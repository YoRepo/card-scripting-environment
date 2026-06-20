--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 威胁的人造人-念力震慑者  (ID: 39987731)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Machine
-- Level 7
-- ATK 2400 | DEF 1500
-- Setcode: 188
--
-- Effect Text:
-- 这个卡名的①②的效果1回合各能使用1次。
-- ①：自己或者对方的场上·墓地有陷阱卡存在的场合才能发动。这张卡从手卡特殊召唤。这个效果特殊召唤的这张卡的等级直到回合结束时变成6星。
-- ②：自己·对方的主要阶段，把这张卡解放才能发动。从自己的手卡·墓地选1只「人造人-念力震慑者」特殊召唤。那之后，可以把对方场上的陷阱卡全部破坏（那些卡在盖放中的场合，翻开确认）。
--[[ __CARD_HEADER_END__ ]]

--脅威の人造人間－サイコ・ショッカー
function c39987731.initial_effect(c)
	aux.AddCodeList(c,77585513)
	--spsummon1
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(39987731,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,39987731)
	e1:SetCondition(c39987731.spcon1)
	e1:SetTarget(c39987731.sptg1)
	e1:SetOperation(c39987731.spop1)
	c:RegisterEffect(e1)
	--spsummon2
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(39987731,1))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_DESTROY)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetRange(LOCATION_MZONE)
	e2:SetHintTiming(0,TIMINGS_CHECK_MONSTER+TIMING_SSET+TIMING_MAIN_END)
	e2:SetCountLimit(1,39987732)
	e2:SetCondition(c39987731.spcon2)
	e2:SetCost(c39987731.spcost2)
	e2:SetTarget(c39987731.sptg2)
	e2:SetOperation(c39987731.spop2)
	c:RegisterEffect(e2)
end
function c39987731.cfilter(c)
	return (c:IsFaceup() or c:IsLocation(LOCATION_GRAVE)) and c:IsType(TYPE_TRAP)
end
function c39987731.spcon1(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c39987731.cfilter,tp,LOCATION_ONFIELD+LOCATION_GRAVE,LOCATION_ONFIELD+LOCATION_GRAVE,1,nil)
end
function c39987731.sptg1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c39987731.spop1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and Duel.SpecialSummonStep(c,0,tp,tp,false,false,POS_FACEUP) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CHANGE_LEVEL)
		e1:SetValue(6)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_DISABLE+RESET_PHASE+PHASE_END)
		c:RegisterEffect(e1)
	end
	Duel.SpecialSummonComplete()
end
function c39987731.spcon2(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetCurrentPhase()==PHASE_MAIN1 or Duel.GetCurrentPhase()==PHASE_MAIN2
end
function c39987731.spcost2(e,tp,eg,ep,ev,re,r,rp,chk)
	e:SetLabel(100)
	local c=e:GetHandler()
	if chk==0 then return c:IsReleasable() and Duel.GetMZoneCount(tp,c)>0 end
	Duel.Release(c,REASON_COST)
end
function c39987731.spfilter(c,e,tp)
	return c:IsCode(77585513) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c39987731.sptg2(e,tp,eg,ep,ev,re,r,rp,chk)
	local res=e:GetLabel()==100 or Duel.GetLocationCount(tp,LOCATION_MZONE)>0
	if chk==0 then
		e:SetLabel(0)
		return res and Duel.IsExistingMatchingCard(c39987731.spfilter,tp,LOCATION_HAND+LOCATION_GRAVE,0,1,nil,e,tp)
	end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND+LOCATION_GRAVE)
end
function c39987731.desfilter(c)
	return c:IsType(TYPE_TRAP) or c39987731.cffilter(c)
end
function c39987731.cffilter(c)
	return c:IsFacedown() and c:IsLocation(LOCATION_SZONE) and c:GetSequence()~=5
end
function c39987731.spop2(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	local c=e:GetHandler()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,aux.NecroValleyFilter(c39987731.spfilter),tp,LOCATION_HAND+LOCATION_GRAVE,0,1,1,nil,e,tp)
	if g:GetCount()>0 and Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)~=0 and Duel.IsExistingMatchingCard(c39987731.desfilter,tp,0,LOCATION_ONFIELD,1,nil) and Duel.SelectYesNo(tp,aux.Stringid(39987731,2)) then
		local sg=Duel.GetMatchingGroup(c39987731.cffilter,tp,0,LOCATION_ONFIELD,nil)
		if sg:GetCount()>0 then Duel.ConfirmCards(tp,sg) end
		local dg=Duel.GetMatchingGroup(Card.IsType,tp,0,LOCATION_ONFIELD,nil,TYPE_TRAP)
		if dg:GetCount()>0 then
			Duel.BreakEffect()
			Duel.Destroy(dg,REASON_EFFECT)
		end
	end
end
