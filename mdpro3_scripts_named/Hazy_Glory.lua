--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 阳炎光轮  (ID: 43708041)
-- Type: Trap / Equip
-- ATK 0 | DEF 0
-- Setcode: 125
--
-- Effect Text:
-- 只要这张卡在场上存在，自己可以把名字带有「阳炎兽」的怪兽召唤的场合需要的解放减少1只。此外，可以通过把场上表侧表示存在的这张卡送去墓地，从自己墓地选择「阳炎光轮」以外的1张名字带有「阳炎」的卡加入手卡
-- 。
--[[ __CARD_HEADER_END__ ]]

--陽炎光輪
function c43708041.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--decrease tribute
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_DECREASE_TRIBUTE)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTargetRange(LOCATION_HAND,0)
	e2:SetTarget(aux.TargetBoolFunction(Card.IsSetCard,0x107d))
	e2:SetValue(0x1)
	c:RegisterEffect(e2)
	--salvage
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(43708041,0))
	e3:SetCategory(CATEGORY_TOHAND)
	e3:SetType(EFFECT_TYPE_QUICK_O)
	e3:SetCode(EVENT_FREE_CHAIN)
	e3:SetRange(LOCATION_SZONE)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetCondition(c43708041.thcon)
	e3:SetCost(c43708041.thcost)
	e3:SetTarget(c43708041.thtg)
	e3:SetOperation(c43708041.thop)
	c:RegisterEffect(e3)
end
function c43708041.thcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsStatus(STATUS_EFFECT_ENABLED)
end
function c43708041.thcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToGraveAsCost() end
	Duel.SendtoGrave(e:GetHandler(),REASON_COST)
end
function c43708041.filter(c)
	return c:IsSetCard(0x7d) and not c:IsCode(43708041) and c:IsAbleToHand()
end
function c43708041.thtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_GRAVE) and c43708041.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c43708041.filter,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectTarget(tp,c43708041.filter,tp,LOCATION_GRAVE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,1,0,0)
end
function c43708041.thop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SendtoHand(tc,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,tc)
	end
end
