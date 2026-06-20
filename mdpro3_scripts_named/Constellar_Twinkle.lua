--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:26
-- Card: 闪烁星圣  (ID: 35544402)
-- Type: Spell
-- ATK 0 | DEF 0
-- Setcode: 83
--
-- Effect Text:
-- 「闪烁星圣」的②的效果1回合只能使用1次。
-- ①：以自己场上1只「星圣」怪兽为对象才能发动。那只怪兽的等级上升1星或者2星。
-- ②：这张卡在墓地存在的场合，把自己墓地1只「星圣」怪兽除外才能发动。墓地的这张卡加入手卡。
--[[ __CARD_HEADER_END__ ]]

--ティンクル・セイクリッド
function c35544402.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(35544402,0))
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetTarget(c35544402.target)
	e1:SetOperation(c35544402.operation)
	c:RegisterEffect(e1)
	--salvage
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(35544402,1))
	e2:SetCategory(CATEGORY_TOHAND)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCountLimit(1,35544402)
	e2:SetCost(c35544402.thcost)
	e2:SetTarget(c35544402.thtg)
	e2:SetOperation(c35544402.thop)
	c:RegisterEffect(e2)
end
function c35544402.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x53) and c:GetLevel()>0
end
function c35544402.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c35544402.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c35544402.filter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c35544402.filter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c35544402.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc:IsFaceup() and tc:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_LEVEL)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		if Duel.SelectOption(tp,aux.Stringid(35544402,2),aux.Stringid(35544402,3))==0 then
			e1:SetValue(1)
		else e1:SetValue(2) end
		tc:RegisterEffect(e1)
	end
end
function c35544402.thfilter(c)
	return c:IsSetCard(0x53) and c:IsType(TYPE_MONSTER) and c:IsAbleToRemoveAsCost()
end
function c35544402.thcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c35544402.thfilter,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,c35544402.thfilter,tp,LOCATION_GRAVE,0,1,1,nil)
	Duel.Remove(g,POS_FACEUP,REASON_COST)
end
function c35544402.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToHand() end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,e:GetHandler(),1,0,0)
end
function c35544402.thop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		Duel.SendtoHand(c,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,c)
	end
end
