--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:24
-- Card: 势不可挡  (ID: 20140382)
-- Type: Trap / Flip
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 自己场上有7星以上的上级召唤的怪兽表侧表示存在的场合才能发动。陷阱卡或者效果怪兽的效果的发动无效并破坏。
--[[ __CARD_HEADER_END__ ]]

--オーバーウェルム
function c20140382.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_NEGATE+CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_CHAINING)
	e1:SetCondition(c20140382.condition)
	e1:SetTarget(c20140382.target)
	e1:SetOperation(c20140382.activate)
	c:RegisterEffect(e1)
end
function c20140382.cfilter(c)
	return c:IsFaceup() and c:IsLevelAbove(7) and c:IsSummonType(SUMMON_TYPE_ADVANCE)
end
function c20140382.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c20140382.cfilter,tp,LOCATION_MZONE,0,1,nil)
		and Duel.IsChainNegatable(ev)
		and (re:IsActiveType(TYPE_MONSTER) or (re:IsActiveType(TYPE_TRAP) and re:IsHasType(EFFECT_TYPE_ACTIVATE)))
end
function c20140382.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
	if re:GetHandler():IsDestructable() and re:GetHandler():IsRelateToEffect(re) then
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,1,0,0)
	end
end
function c20140382.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.NegateActivation(ev) and re:GetHandler():IsRelateToEffect(re) then
		Duel.Destroy(eg,REASON_EFFECT)
	end
end
