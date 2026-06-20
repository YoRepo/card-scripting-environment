--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 魔偶甜点茶休  (ID: 75833426)
-- Type: Trap / Flip
-- ATK 0 | DEF 0
-- Setcode: 113
--
-- Effect Text:
-- 自己墓地没有怪兽存在的场合才能发动。魔法·陷阱卡的发动无效，那张卡回到持有者手卡。自己场上有「魔偶甜点·布丁公主」存在的场合，可以再选对方场上1张卡破坏。
--[[ __CARD_HEADER_END__ ]]

--マドルチェ・ティーブレイク
function c75833426.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_NEGATE+CATEGORY_TOHAND+CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_CHAINING)
	e1:SetCondition(c75833426.condition)
	e1:SetTarget(c75833426.target)
	e1:SetOperation(c75833426.activate)
	c:RegisterEffect(e1)
end
function c75833426.condition(e,tp,eg,ep,ev,re,r,rp)
	return not Duel.IsExistingMatchingCard(Card.IsType,tp,LOCATION_GRAVE,0,1,nil,TYPE_MONSTER)
		and re:IsHasType(EFFECT_TYPE_ACTIVATE) and Duel.IsChainNegatable(ev)
end
function c75833426.cfilter(c)
	return c:IsFaceup() and c:IsCode(74641045)
end
function c75833426.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
	if re:GetHandler():IsRelateToEffect(re) then
		Duel.SetOperationInfo(0,CATEGORY_TOHAND,eg,1,0,0)
	end
end
function c75833426.activate(e,tp,eg,ep,ev,re,r,rp)
	local ec=re:GetHandler()
	if Duel.NegateActivation(ev) and re:GetHandler():IsRelateToEffect(re) then
		ec:CancelToGrave()
		Duel.SendtoHand(ec,nil,REASON_EFFECT)
	end
	if Duel.IsExistingMatchingCard(c75833426.cfilter,tp,LOCATION_MZONE,0,1,nil)
		and Duel.IsExistingMatchingCard(aux.TRUE,tp,0,LOCATION_ONFIELD,1,nil)
		and Duel.SelectYesNo(tp,aux.Stringid(75833426,0)) then
		Duel.BreakEffect()
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
		local g=Duel.SelectMatchingCard(tp,aux.TRUE,tp,0,LOCATION_ONFIELD,1,1,nil)
		Duel.HintSelection(g)
		Duel.Destroy(g,REASON_EFFECT)
	end
end
