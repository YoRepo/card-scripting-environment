--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 壹世坏清澈的残响  (ID: 1329620)
-- Type: Trap / Flip
-- ATK 0 | DEF 0
-- Setcode: 385
--
-- Effect Text:
-- 这个卡名的①②的效果1回合只能有1次使用其中任意1个。
-- ①：自己场上有「珠泪哀歌族」怪兽或者「维萨斯-斯塔弗罗斯特」存在，怪兽的效果·魔法·陷阱卡发动时才能发动。那个发动无效，那张卡回到持有者卡组。那之后，从自己手卡选1只怪兽送去墓地。
-- ②：这张卡被效果送去墓地的场合，以除外的1只自己的「珠泪哀歌族」怪兽为对象才能发动。那只怪兽加入手卡。
--[[ __CARD_HEADER_END__ ]]

--壱世壊に澄み渡る残響
function c1329620.initial_effect(c)
	aux.AddCodeList(c,56099748)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_NEGATE+CATEGORY_TODECK+CATEGORY_TOGRAVE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_CHAINING)
	e1:SetCountLimit(1,1329620)
	e1:SetCondition(c1329620.condition)
	e1:SetTarget(c1329620.target)
	e1:SetOperation(c1329620.activate)
	c:RegisterEffect(e1)
	--to hand
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_TOHAND)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_TO_GRAVE)
	e2:SetProperty(EFFECT_FLAG_DELAY+EFFECT_FLAG_CARD_TARGET)
	e2:SetCountLimit(1,1329620)
	e2:SetCondition(c1329620.thcon)
	e2:SetTarget(c1329620.thtg)
	e2:SetOperation(c1329620.thop)
	c:RegisterEffect(e2)
end
function c1329620.actcfilter(c)
	return ((c:IsSetCard(0x181) and c:IsLocation(LOCATION_MZONE)) or c:IsCode(56099748)) and c:IsFaceup()
end
function c1329620.condition(e,tp,eg,ep,ev,re,r,rp)
	return (re:IsActiveType(TYPE_MONSTER) or re:IsHasType(EFFECT_TYPE_ACTIVATE)) and Duel.IsChainNegatable(ev)
		and Duel.IsExistingMatchingCard(c1329620.actcfilter,tp,LOCATION_ONFIELD,0,1,nil)
end
function c1329620.cfilter(c)
	return c:IsType(TYPE_MONSTER) and c:IsAbleToGrave()
end
function c1329620.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c1329620.cfilter,tp,LOCATION_HAND,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
	if re:GetHandler():IsRelateToEffect(re) then
		Duel.SetOperationInfo(0,CATEGORY_TODECK,eg,1,0,0)
	end
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,1,tp,LOCATION_HAND)
end
function c1329620.activate(e,tp,eg,ep,ev,re,r,rp)
	local ec=re:GetHandler()
	if Duel.NegateActivation(ev) and ec:IsRelateToEffect(re) then
		ec:CancelToGrave()
		if Duel.SendtoDeck(ec,nil,SEQ_DECKSHUFFLE,REASON_EFFECT)~=0 and ec:IsLocation(LOCATION_DECK+LOCATION_EXTRA) then
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
			local g=Duel.SelectMatchingCard(tp,c1329620.cfilter,tp,LOCATION_HAND,0,1,1,nil)
			if #g>0 then
				Duel.BreakEffect()
				Duel.SendtoGrave(g,REASON_EFFECT)
			end
		end
	end
end
function c1329620.thcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsReason(REASON_EFFECT)
end
function c1329620.thfilter(c)
	return c:IsSetCard(0x181) and c:IsType(TYPE_MONSTER) and c:IsFaceup() and c:IsAbleToHand()
end
function c1329620.thtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_REMOVED) and chkc:IsControler(tp) and c1329620.thfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c1329620.thfilter,tp,LOCATION_REMOVED,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectTarget(tp,c1329620.thfilter,tp,LOCATION_REMOVED,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,1,0,0)
end
function c1329620.thop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SendtoHand(tc,nil,REASON_EFFECT)
	end
end
