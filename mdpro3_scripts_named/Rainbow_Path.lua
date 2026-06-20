--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 虹之行方  (ID: 7617253)
-- Type: Trap
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 对方怪兽的攻击宣言时，选择自己的魔法与陷阱卡区域存在的1张名字带有「宝玉兽」的卡送去墓地发动。可以把1只对方怪兽的攻击无效，从自己卡组选择1张名字带有「究极宝玉神」的卡加入手卡。
--[[ __CARD_HEADER_END__ ]]

--虹の行方
function c7617253.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetCondition(c7617253.condition)
	e1:SetCost(c7617253.cost)
	e1:SetTarget(c7617253.target)
	e1:SetOperation(c7617253.activate)
	c:RegisterEffect(e1)
end
function c7617253.condition(e,tp,eg,ep,ev,re,r,rp)
	return tp~=Duel.GetTurnPlayer()
end
function c7617253.costfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x1034) and c:IsAbleToGraveAsCost()
end
function c7617253.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c7617253.costfilter,tp,LOCATION_SZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c7617253.costfilter,tp,LOCATION_SZONE,0,1,1,nil)
	Duel.SendtoGrave(g,REASON_COST)
end
function c7617253.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local tg=Duel.GetAttacker()
	if chkc then return chkc==tg end
	if chk==0 then return tg:IsOnField() and tg:IsCanBeEffectTarget(e) end
	Duel.SetTargetCard(tg)
end
function c7617253.filter(c)
	return c:IsSetCard(0x2034) and c:IsAbleToHand()
end
function c7617253.activate(e,tp,eg,ep,ev,re,r,rp)
	local tg=Duel.GetAttacker()
	if not tg:IsRelateToEffect(e) or tg:IsStatus(STATUS_ATTACK_CANCELED)
		or not Duel.NegateAttack() then return end
	local g=Duel.GetMatchingGroup(c7617253.filter,tp,LOCATION_DECK,0,nil)
	if g:GetCount()>0 and Duel.SelectYesNo(tp,aux.Stringid(7617253,0)) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
		local sg=g:Select(tp,1,1,nil)
		Duel.BreakEffect()
		Duel.SendtoHand(sg,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,sg)
	end
end
