--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 地缚波  (ID: 29934351)
-- Type: Trap / Flip
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 自己场上有名字带有「地缚神」的怪兽表侧表示存在的场合才能发动。对方的魔法·陷阱卡的发动无效并破坏。
--[[ __CARD_HEADER_END__ ]]

--地縛波
function c29934351.initial_effect(c)
	--negate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_NEGATE+CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_CHAINING)
	e1:SetCondition(c29934351.condition)
	e1:SetTarget(c29934351.target)
	e1:SetOperation(c29934351.activate)
	c:RegisterEffect(e1)
end
function c29934351.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x1021)
end
function c29934351.condition(e,tp,eg,ep,ev,re,r,rp)
	return rp==1-tp and re:IsHasType(EFFECT_TYPE_ACTIVATE) and Duel.IsChainNegatable(ev)
		and Duel.IsExistingMatchingCard(c29934351.cfilter,tp,LOCATION_MZONE,0,1,nil)
end
function c29934351.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
	if re:GetHandler():IsDestructable() and re:GetHandler():IsRelateToEffect(re) then
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,1,0,0)
	end
end
function c29934351.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.NegateActivation(ev) and re:GetHandler():IsRelateToEffect(re) then
		Duel.Destroy(eg,REASON_EFFECT)
	end
end
