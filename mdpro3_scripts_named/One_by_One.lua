--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:36
-- Card: 一接一  (ID: 91534476)
-- Type: Trap
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 这个卡名的卡在1回合只能发动1张。
-- ①：从自己的手卡·场上把1只怪兽送去墓地，从自己墓地的怪兽以及除外的自己怪兽之中以送去墓地的怪兽以外的1只1星怪兽为对象才能发动。那只怪兽加入手卡。
--[[ __CARD_HEADER_END__ ]]

--ワン・バイ・ワン
function c91534476.initial_effect(c)
	--to hand
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCountLimit(1,91534476+EFFECT_COUNT_CODE_OATH)
	e1:SetCost(c91534476.cost)
	e1:SetTarget(c91534476.target)
	e1:SetOperation(c91534476.operation)
	c:RegisterEffect(e1)
end
function c91534476.cfilter(c)
	return c:IsType(TYPE_MONSTER) and c:IsAbleToGraveAsCost()
end
function c91534476.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c91534476.cfilter,tp,LOCATION_HAND+LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c91534476.cfilter,tp,LOCATION_HAND+LOCATION_MZONE,0,1,1,nil)
	Duel.SendtoGrave(g,REASON_COST)
	e:SetLabelObject(g:GetFirst())
end
function c91534476.thfilter(c)
	return c:IsLevel(1) and (c:IsFaceup() or c:IsLocation(LOCATION_GRAVE)) and c:IsAbleToHand()
end
function c91534476.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE+LOCATION_REMOVED) and chkc:IsControler(tp) and c91534476.thfilter(chkc) and chkc~=e:GetLabelObject() end
	if chk==0 then return Duel.IsExistingTarget(c91534476.thfilter,tp,LOCATION_GRAVE+LOCATION_REMOVED,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectTarget(tp,c91534476.thfilter,tp,LOCATION_GRAVE+LOCATION_REMOVED,0,1,1,e:GetLabelObject())
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,1,0,0)
end
function c91534476.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SendtoHand(tc,nil,REASON_EFFECT)
	end
end
