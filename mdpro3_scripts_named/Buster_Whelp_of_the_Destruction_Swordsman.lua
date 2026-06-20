--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: 破坏剑士的伴龙  (ID: 49823708)
-- Type: Monster / Effect / Tuner
-- Attribute: LIGHT
-- Race: Dragon
-- Level 1
-- ATK 400 | DEF 300
-- Setcode: 214
--
-- Effect Text:
-- 这个卡名的②③的效果1回合只能有1次使用其中任意1个。
-- ①：这张卡召唤成功时才能发动。从卡组把「破坏剑士的伴龙」以外的1张「破坏剑」卡加入手卡。
-- ②：把这张卡解放才能发动。从自己的手卡·墓地选1只「破坏之剑士」特殊召唤。
-- ③：这张卡在墓地存在，自己场上有「破坏之剑士」存在的场合，从手卡丢弃1张「破坏剑」卡才能发动。这张卡特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--破壊剣士の伴竜
function c49823708.initial_effect(c)
	--search
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetTarget(c49823708.target)
	e1:SetOperation(c49823708.operation)
	c:RegisterEffect(e1)
	--spsummon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(49823708,0))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1,49823708)
	e2:SetCost(c49823708.spcost)
	e2:SetTarget(c49823708.sptg)
	e2:SetOperation(c49823708.spop)
	c:RegisterEffect(e2)
	--special summon
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(49823708,1))
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_GRAVE)
	e3:SetCountLimit(1,49823708)
	e3:SetCondition(c49823708.spcon2)
	e3:SetCost(c49823708.spcost2)
	e3:SetTarget(c49823708.sptg2)
	e3:SetOperation(c49823708.spop2)
	c:RegisterEffect(e3)
end
function c49823708.filter(c)
	return c:IsSetCard(0xd6) and not c:IsCode(49823708) and c:IsAbleToHand()
end
function c49823708.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c49823708.filter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c49823708.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c49823708.filter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
function c49823708.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsReleasable() end
	Duel.Release(e:GetHandler(),REASON_COST)
end
function c49823708.spfilter(c,e,tp)
	return c:IsCode(78193831) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c49823708.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>-1
		and Duel.IsExistingMatchingCard(c49823708.spfilter,tp,LOCATION_GRAVE+LOCATION_HAND,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_GRAVE+LOCATION_HAND)
end
function c49823708.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,aux.NecroValleyFilter(c49823708.spfilter),tp,LOCATION_GRAVE+LOCATION_HAND,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
function c49823708.cfilter(c)
	return c:IsFaceup() and c:IsCode(78193831)
end
function c49823708.spcon2(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c49823708.cfilter,tp,LOCATION_MZONE,0,1,nil)
end
function c49823708.costfilter(c)
	return c:IsSetCard(0xd6) and c:IsAbleToGraveAsCost()
end
function c49823708.spcost2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c49823708.costfilter,tp,LOCATION_HAND,0,1,nil) end
	Duel.DiscardHand(tp,c49823708.costfilter,1,1,REASON_COST)
end
function c49823708.sptg2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c49823708.spop2(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
	end
end
