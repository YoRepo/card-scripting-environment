--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 来自墓场的呼声  (ID: 16970158)
-- Type: Trap
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 对方把「死者苏生」发动时才能发动。那张「死者苏生」的效果无效。
--[[ __CARD_HEADER_END__ ]]

--墓場からの呼び声
function c16970158.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DISABLE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_CHAINING)
	e1:SetCondition(c16970158.condition)
	e1:SetTarget(c16970158.target)
	e1:SetOperation(c16970158.activate)
	c:RegisterEffect(e1)
end
function c16970158.condition(e,tp,eg,ep,ev,re,r,rp)
	return rp==1-tp and re:IsHasType(EFFECT_TYPE_ACTIVATE) and re:GetHandler():IsCode(83764718) and Duel.IsChainDisablable(ev)
end
function c16970158.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DISABLE,eg,1,0,0)
end
function c16970158.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateEffect(ev)
end
