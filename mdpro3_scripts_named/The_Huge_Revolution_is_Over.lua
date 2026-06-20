--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:37
-- Card: 反大革命  (ID: 99188141)
-- Type: Trap / Flip
-- ATK 0 | DEF 0
--
-- Effect Text:
-- ①：要让场上的卡2张以上破坏的怪兽的效果·魔法·陷阱卡发动时才能发动。那个发动无效并除外。
--[[ __CARD_HEADER_END__ ]]

--大革命返し
function c99188141.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_NEGATE+CATEGORY_REMOVE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_CHAINING)
	e1:SetCondition(c99188141.condition)
	e1:SetTarget(aux.nbtg)
	e1:SetOperation(c99188141.activate)
	c:RegisterEffect(e1)
end
function c99188141.condition(e,tp,eg,ep,ev,re,r,rp)
	if (not re:IsActiveType(TYPE_MONSTER) and not re:IsHasType(EFFECT_TYPE_ACTIVATE))
		or not Duel.IsChainNegatable(ev) then return false end
	local ex,tg,tc=Duel.GetOperationInfo(ev,CATEGORY_DESTROY)
	return ex and tg~=nil and tc+tg:FilterCount(Card.IsOnField,nil)-tg:GetCount()>1
end
function c99188141.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.NegateActivation(ev) and re:GetHandler():IsRelateToEffect(re) then
		Duel.Remove(re:GetHandler(),POS_FACEUP,REASON_EFFECT)
	end
end
