--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 毛绒动物·熊  (ID: 3841833)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Fairy
-- Level 3
-- ATK 1200 | DEF 800
-- Setcode: 169
--
-- Effect Text:
-- 「毛绒动物·熊」的①②的效果1回合只能有1次使用其中任意1个。
-- ①：把手卡的这张卡送去墓地才能发动。从卡组选1张「玩具罐」在自己的魔法与陷阱区域盖放。
-- ②：把这张卡解放，以自己墓地1张「融合」为对象才能发动。那张卡加入手卡。
--[[ __CARD_HEADER_END__ ]]

--ファーニマル・ベア
function c3841833.initial_effect(c)
	--sset
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(3841833,0))
	e1:SetCategory(CATEGORY_SSET)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,3841833)
	e1:SetCost(c3841833.cost)
	e1:SetTarget(c3841833.target)
	e1:SetOperation(c3841833.operation)
	c:RegisterEffect(e1)
	--tohand
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(3841833,1))
	e2:SetCategory(CATEGORY_TOHAND)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1,3841833)
	e2:SetCost(c3841833.thcost)
	e2:SetTarget(c3841833.thtg)
	e2:SetOperation(c3841833.thop)
	c:RegisterEffect(e2)
end
function c3841833.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToGraveAsCost() and e:GetHandler():IsDiscardable() end
	Duel.SendtoGrave(e:GetHandler(),REASON_COST)
end
function c3841833.filter(c)
	return c:IsCode(70245411) and c:IsSSetable()
end
function c3841833.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_SZONE)>0
		and Duel.IsExistingMatchingCard(c3841833.filter,tp,LOCATION_DECK,0,1,nil) end
end
function c3841833.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SET)
	local g=Duel.SelectMatchingCard(tp,c3841833.filter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SSet(tp,g:GetFirst())
	end
end
function c3841833.thcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsReleasable() end
	Duel.Release(e:GetHandler(),REASON_COST)
end
function c3841833.thfilter(c)
	return c:IsCode(24094653) and c:IsAbleToHand()
end
function c3841833.thtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c3841833.thfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c3841833.thfilter,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectTarget(tp,c3841833.thfilter,tp,LOCATION_GRAVE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,1,0,0)
end
function c3841833.thop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SendtoHand(tc,nil,REASON_EFFECT)
	end
end
