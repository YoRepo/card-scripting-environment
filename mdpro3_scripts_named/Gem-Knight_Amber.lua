--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 宝石骑士·琥珀  (ID: 72056560)
-- Type: Monster / Effect / Gemini
-- Attribute: EARTH
-- Race: Thunder
-- Level 4
-- ATK 1600 | DEF 1400
-- Setcode: 4167
--
-- Effect Text:
-- 这张卡在墓地或者场上表侧表示存在的场合，当作通常怪兽使用。场上表侧表示存在的这张卡可以作当成通常召唤使用的再度召唤，这张卡变成当作效果怪兽使用并得到以下效果。
-- ●1回合1次，可以从手卡把1张名字带有「宝石骑士」的卡送去墓地，选择从游戏中除外的1只自己怪兽回到手卡。
--[[ __CARD_HEADER_END__ ]]

--ジェムナイト・アンバー
function c72056560.initial_effect(c)
	aux.EnableDualAttribute(c)
	--salvage
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetDescription(aux.Stringid(72056560,0))
	e1:SetCategory(CATEGORY_TOHAND)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCondition(aux.IsDualState)
	e1:SetCost(c72056560.cost)
	e1:SetTarget(c72056560.target)
	e1:SetOperation(c72056560.operation)
	c:RegisterEffect(e1)
end
function c72056560.costfilter(c)
	return c:IsSetCard(0x1047) and c:IsAbleToGraveAsCost()
end
function c72056560.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c72056560.costfilter,tp,LOCATION_HAND,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c72056560.costfilter,tp,LOCATION_HAND,0,1,1,nil)
	Duel.SendtoGrave(g,REASON_COST)
end
function c72056560.tgfilter(c)
	return c:IsFaceup() and c:IsType(TYPE_MONSTER) and c:IsAbleToHand()
end
function c72056560.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_REMOVED) and chkc:IsControler(tp) and c72056560.tgfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c72056560.tgfilter,tp,LOCATION_REMOVED,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectTarget(tp,c72056560.tgfilter,tp,LOCATION_REMOVED,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,1,0,0)
end
function c72056560.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		Duel.SendtoHand(tc,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,tc)
	end
end
