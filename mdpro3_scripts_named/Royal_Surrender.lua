--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:30
-- Card: 王宫的陷落  (ID: 56058888)
-- Type: Trap / Flip
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 对方发动永续陷阱卡时才能发动。那张卡的发动和效果无效，并且破坏。
--[[ __CARD_HEADER_END__ ]]

--王宮の陥落
function c56058888.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_NEGATE+CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_CHAINING)
	e1:SetCondition(c56058888.condition)
	e1:SetTarget(c56058888.target)
	e1:SetOperation(c56058888.activate)
	c:RegisterEffect(e1)
end
function c56058888.condition(e,tp,eg,ep,ev,re,r,rp)
	return rp==1-tp and re:IsHasType(EFFECT_TYPE_ACTIVATE) and re:GetActiveType()==TYPE_TRAP+TYPE_CONTINUOUS and Duel.IsChainNegatable(ev)
end
function c56058888.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
	if re:GetHandler():IsDestructable() and re:GetHandler():IsRelateToEffect(re) then
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,1,0,0)
	end
end
function c56058888.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.NegateActivation(ev) and re:GetHandler():IsRelateToEffect(re) then
		Duel.Destroy(eg,REASON_EFFECT)
	end
end
