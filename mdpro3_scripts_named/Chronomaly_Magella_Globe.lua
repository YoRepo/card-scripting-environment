--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:37
-- Card: 先史遗产 墨瓦腊地球仪  (ID: 97112505)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Machine
-- Level 4
-- ATK 1500 | DEF 300
-- Setcode: 112
--
-- Effect Text:
-- 这个卡名的①②的效果1回合各能使用1次。
-- ①：把这张卡解放才能发动。从卡组把「先史遗产 墨瓦腊地球仪」以外的1只「先史遗产」怪兽特殊召唤。
-- ②：这张卡在墓地存在的场合，从自己墓地把「先史遗产 墨瓦腊地球仪」以外的1张「先史遗产」卡除外才能发动。这张卡加入手卡。这个效果在这张卡送去墓地的回合不能发动。
--[[ __CARD_HEADER_END__ ]]

--先史遺産メガラ・グローヴ
function c97112505.initial_effect(c)
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(97112505,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1,97112505)
	e1:SetCost(c97112505.spcost)
	e1:SetTarget(c97112505.sptg)
	e1:SetOperation(c97112505.spop)
	c:RegisterEffect(e1)
	--tohand
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(97112505,1))
	e2:SetCategory(CATEGORY_TOHAND)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCountLimit(1,97112506)
	e2:SetCondition(aux.exccon)
	e2:SetCost(c97112505.thcost)
	e2:SetTarget(c97112505.thtg)
	e2:SetOperation(c97112505.thop)
	c:RegisterEffect(e2)
end
function c97112505.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsReleasable() end
	Duel.Release(e:GetHandler(),REASON_COST)
end
function c97112505.spfilter(c,e,tp)
	return c:IsSetCard(0x70) and c:IsCanBeSpecialSummoned(e,0,tp,false,false) and not c:IsCode(97112505)
end
function c97112505.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetMZoneCount(tp,e:GetHandler())>0
		and Duel.IsExistingMatchingCard(c97112505.spfilter,tp,LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c97112505.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c97112505.spfilter,tp,LOCATION_DECK,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
function c97112505.thcfilter(c)
	return c:IsSetCard(0x70) and c:IsAbleToRemoveAsCost() and not c:IsCode(97112505)
end
function c97112505.thcost(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return Duel.IsExistingMatchingCard(c97112505.thcfilter,tp,LOCATION_GRAVE,0,1,c) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,c97112505.thcfilter,tp,LOCATION_GRAVE,0,1,1,c)
	Duel.Remove(g,POS_FACEUP,REASON_COST)
end
function c97112505.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToHand() end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,e:GetHandler(),1,0,0)
end
function c97112505.thop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		Duel.SendtoHand(c,nil,REASON_EFFECT)
	end
end
