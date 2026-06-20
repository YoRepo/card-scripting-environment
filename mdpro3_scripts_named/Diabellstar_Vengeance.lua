--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:24
-- Card: 断罪之迪亚贝尔斯塔尔  (ID: 23151193)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Fiend
-- Level 8
-- ATK 2500 | DEF 2100
-- Setcode: 27136411
--
-- Effect Text:
-- 这个卡名在规则上也当作「罪宝」卡使用。这个卡名的①②的效果1回合各能使用1次。
-- ①：从自己的手卡·墓地把魔法卡和陷阱卡各1张除外才能发动。这张卡从手卡·墓地特殊召唤。
-- ②：自己·对方回合，把基本分支付一半，以对方场上1张卡为对象才能发动。那张卡破坏。那之后，场上有其他的「迪亚贝尔」怪兽卡存在的场合，可以从额外卡组把1只幻想魔族·魔法师族同调怪兽调整特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--断罪のディアベルスター
local s,id,o=GetID()
function s.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(id,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_HAND+LOCATION_GRAVE)
	e1:SetCountLimit(1,id)
	e1:SetCost(s.spcost)
	e1:SetTarget(s.sptg)
	e1:SetOperation(s.spop)
	c:RegisterEffect(e1)
	--destroy
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(id,1))
	e2:SetCategory(CATEGORY_DESTROY+CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetRange(LOCATION_MZONE)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetHintTiming(0,TIMINGS_CHECK_MONSTER+TIMING_END_PHASE)
	e2:SetCountLimit(1,id+o)
	e2:SetCost(s.descost)
	e2:SetTarget(s.destg)
	e2:SetOperation(s.desop)
	c:RegisterEffect(e2)
end
function s.spcostfilter1(c)
	return c:IsAbleToRemoveAsCost() and c:IsType(TYPE_SPELL)
end
function s.spcostfilter2(c)
	return c:IsAbleToRemoveAsCost() and c:IsType(TYPE_TRAP)
end
function s.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(s.spcostfilter1,tp,LOCATION_GRAVE+LOCATION_HAND,0,1,e:GetHandler())
		and Duel.IsExistingMatchingCard(s.spcostfilter2,tp,LOCATION_GRAVE+LOCATION_HAND,0,1,e:GetHandler()) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local sg=Duel.SelectMatchingCard(tp,s.spcostfilter1,tp,LOCATION_GRAVE+LOCATION_HAND,0,1,1,e:GetHandler())
	local sg2=Duel.SelectMatchingCard(tp,s.spcostfilter2,tp,LOCATION_GRAVE+LOCATION_HAND,0,1,1,e:GetHandler())
	Duel.Remove(sg+sg2,POS_FACEUP,REASON_COST)
end
function s.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function s.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and aux.NecroValleyFilter()(c) then
		Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
	end
end
function s.descost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.PayLPCost(tp,math.floor(Duel.GetLP(tp)/2))
end
function s.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and chkc:IsControler(1-tp) end
	if chk==0 then return Duel.IsExistingTarget(nil,tp,0,LOCATION_ONFIELD,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,nil,tp,0,LOCATION_ONFIELD,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function s.spfilter(c,e,tp)
	return c:IsAllTypes(TYPE_SYNCHRO+TYPE_MONSTER+TYPE_TUNER)
		and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
		and c:IsRace(RACE_ILLUSION+RACE_SPELLCASTER)
		and Duel.GetLocationCountFromEx(tp,tp,nil,c)>0
end
function s.spconfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x19b) and c:GetOriginalType()&TYPE_MONSTER~=0
end
function s.desop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and Duel.Destroy(tc,REASON_EFFECT)~=0
		and Duel.IsExistingMatchingCard(s.spconfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,aux.ExceptThisCard(e))
		and Duel.IsExistingMatchingCard(s.spfilter,tp,LOCATION_EXTRA,0,1,nil,e,tp)
		and Duel.SelectYesNo(tp,aux.Stringid(id,2)) then
		Duel.BreakEffect()
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local g=Duel.SelectMatchingCard(tp,s.spfilter,tp,LOCATION_EXTRA,0,1,1,nil,e,tp)
		if g:GetCount()>0 then
			Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
		end
	end
end
