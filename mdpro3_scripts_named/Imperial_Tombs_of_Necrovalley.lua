--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: 王家长眠之谷的王墓  (ID: 90434657)
-- Type: Trap / Flip
-- ATK 0 | DEF 0
-- Setcode: 145
--
-- Effect Text:
-- 场上有名字带有「守墓」的怪兽以及「王家长眠之谷」存在的场合才能发动。效果怪兽的效果·魔法·陷阱卡的发动无效并破坏。「王家长眠之谷的王墓」在1回合只能发动1张。
--[[ __CARD_HEADER_END__ ]]

--ネクロバレーの王墓
function c90434657.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_NEGATE+CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_CHAINING)
	e1:SetCountLimit(1,90434657+EFFECT_COUNT_CODE_OATH)
	e1:SetCondition(c90434657.condition)
	e1:SetTarget(c90434657.target)
	e1:SetOperation(c90434657.activate)
	c:RegisterEffect(e1)
end
function c90434657.cfilter1(c)
	return c:IsFaceup() and c:IsSetCard(0x2e)
end
function c90434657.condition(e,tp,eg,ep,ev,re,r,rp)
	if not Duel.IsExistingMatchingCard(c90434657.cfilter1,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil)
		or not Duel.IsEnvironment(47355498) then return false end
	if not Duel.IsChainNegatable(ev) then return false end
	return re:IsActiveType(TYPE_MONSTER) or re:IsHasType(EFFECT_TYPE_ACTIVATE)
end
function c90434657.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
	if re:GetHandler():IsDestructable() and re:GetHandler():IsRelateToEffect(re) then
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,1,0,0)
	end
end
function c90434657.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.NegateActivation(ev) and re:GetHandler():IsRelateToEffect(re) then
		Duel.Destroy(eg,REASON_EFFECT)
	end
end
