--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 神罚  (ID: 81066751)
-- Type: Trap / Flip
-- ATK 0 | DEF 0
--
-- Effect Text:
-- ①：场上有「天空的圣域」存在，怪兽的效果·魔法·陷阱卡发动时才能发动。那个发动无效并破坏。
--[[ __CARD_HEADER_END__ ]]

--神罰
function c81066751.initial_effect(c)
	aux.AddCodeList(c,56433456)
	--Activate(effect)
	local e4=Effect.CreateEffect(c)
	e4:SetCategory(CATEGORY_NEGATE+CATEGORY_DESTROY)
	e4:SetType(EFFECT_TYPE_ACTIVATE)
	e4:SetCode(EVENT_CHAINING)
	e4:SetCondition(c81066751.condition)
	e4:SetTarget(c81066751.target)
	e4:SetOperation(c81066751.activate)
	c:RegisterEffect(e4)
end
function c81066751.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsEnvironment(56433456) and Duel.IsChainNegatable(ev)
		and (re:IsActiveType(TYPE_MONSTER) or re:IsHasType(EFFECT_TYPE_ACTIVATE))
end
function c81066751.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
	if re:GetHandler():IsDestructable() and re:GetHandler():IsRelateToEffect(re) then
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,1,0,0)
	end
end
function c81066751.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.NegateActivation(ev) and re:GetHandler():IsRelateToEffect(re) then
		Duel.Destroy(eg,REASON_EFFECT)
	end
end
