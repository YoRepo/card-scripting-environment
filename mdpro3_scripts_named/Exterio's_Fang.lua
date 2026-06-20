--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 木龙兽之牙  (ID: 68456353)
-- Type: Trap / Flip
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 自己场上有名字带有「自然」的怪兽表侧表示存在的场合才能发动。对方发动的魔法·陷阱卡的发动无效并破坏。那之后，把自己1张手卡送去墓地。
--[[ __CARD_HEADER_END__ ]]

--エクストリオの牙
function c68456353.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_NEGATE+CATEGORY_DESTROY+CATEGORY_TOGRAVE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_CHAINING)
	e1:SetCondition(c68456353.condition)
	e1:SetTarget(c68456353.target)
	e1:SetOperation(c68456353.activate)
	c:RegisterEffect(e1)
end
function c68456353.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x2a)
end
function c68456353.condition(e,tp,eg,ep,ev,re,r,rp)
	return re:IsHasType(EFFECT_TYPE_ACTIVATE) and rp==1-tp and Duel.IsChainNegatable(ev)
		and Duel.IsExistingMatchingCard(c68456353.cfilter,tp,LOCATION_MZONE,0,1,nil)
end
function c68456353.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFieldGroupCount(tp,LOCATION_HAND,0)>0 end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
	if re:GetHandler():IsDestructable() and re:GetHandler():IsRelateToEffect(re) then
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,1,0,0)
	end
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,1,tp,LOCATION_HAND)
end
function c68456353.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.NegateActivation(ev) and re:GetHandler():IsRelateToEffect(re) then
		Duel.Destroy(eg,REASON_EFFECT)
	end
	Duel.DiscardHand(tp,nil,1,1,REASON_EFFECT,nil)
end
