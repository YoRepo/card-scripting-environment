--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:37
-- Card: 混沌领域  (ID: 99266988)
-- Type: Spell
-- ATK 0 | DEF 0
-- Setcode: 207
--
-- Effect Text:
-- 这个卡名的①②的效果1回合各能使用1次。
-- ①：从手卡把1只光·暗属性怪兽送去墓地才能发动。和那只怪兽属性不同并是4～8星的1只不能通常召唤的光·暗属性怪兽从卡组加入手卡。
-- ②：把墓地的这张卡除外，从除外的自己怪兽之中以1只不能通常召唤的光·暗属性怪兽为对象才能发动。那只怪兽回到卡组最下面。那之后，自己从卡组抽1张。
--[[ __CARD_HEADER_END__ ]]

--混沌領域
function c99266988.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(99266988,0))
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,99266988)
	e1:SetCost(c99266988.cost)
	e1:SetTarget(c99266988.target)
	e1:SetOperation(c99266988.activate)
	c:RegisterEffect(e1)
	--todeck
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(99266988,1))
	e2:SetCategory(CATEGORY_TODECK+CATEGORY_DRAW)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCountLimit(1,99266989)
	e2:SetCost(aux.bfgcost)
	e2:SetTarget(c99266988.tg)
	e2:SetOperation(c99266988.op)
	c:RegisterEffect(e2)
end
function c99266988.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	e:SetLabel(100)
	return true
end
function c99266988.tgfilter(c,tp)
	return c:IsAttribute(ATTRIBUTE_LIGHT+ATTRIBUTE_DARK) and c:IsAbleToGraveAsCost()
		and Duel.IsExistingMatchingCard(c99266988.thfilter,tp,LOCATION_DECK,0,1,nil,c:GetAttribute())
end
function c99266988.thfilter(c,att)
	return c:IsAttribute(ATTRIBUTE_LIGHT+ATTRIBUTE_DARK) and not c:IsAttribute(att)
		and c:IsAbleToHand() and c:IsLevelAbove(4) and c:IsLevelBelow(8) and not c:IsSummonableCard()
end
function c99266988.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		if e:GetLabel()~=100 then return false end
		e:SetLabel(0)
		return Duel.IsExistingMatchingCard(c99266988.tgfilter,tp,LOCATION_HAND,0,1,nil,tp)
	end
	local rg=Duel.SelectMatchingCard(tp,c99266988.tgfilter,tp,LOCATION_HAND,0,1,1,nil,tp)
	e:SetLabel(rg:GetFirst():GetAttribute())
	Duel.SendtoGrave(rg,REASON_COST)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c99266988.activate(e,tp,eg,ep,ev,re,r,rp)
	local att=e:GetLabel()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c99266988.thfilter,tp,LOCATION_DECK,0,1,1,nil,att)
	local tc=g:GetFirst()
	if tc then
		Duel.SendtoHand(tc,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,tc)
	end
end
function c99266988.tdfilter(c)
	return c:IsFaceup() and c:IsAttribute(ATTRIBUTE_LIGHT+ATTRIBUTE_DARK) and not c:IsSummonableCard() and c:IsAbleToDeck()
end
function c99266988.tg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_REMOVED) and chkc:IsControler(tp) and c99266988.tdfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c99266988.tdfilter,tp,LOCATION_REMOVED,0,1,nil) and Duel.IsPlayerCanDraw(tp,1) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g=Duel.SelectTarget(tp,c99266988.tdfilter,tp,LOCATION_REMOVED,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,g,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c99266988.op(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		if Duel.SendtoDeck(tc,nil,SEQ_DECKBOTTOM,REASON_EFFECT)~=0 and tc:IsLocation(LOCATION_DECK+LOCATION_EXTRA) then
			Duel.BreakEffect()
			Duel.Draw(tp,1,REASON_EFFECT)
		end
	end
end
