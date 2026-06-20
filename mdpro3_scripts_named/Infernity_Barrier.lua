--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: 永火防护罩  (ID: 9059700)
-- Type: Trap / Flip
-- ATK 0 | DEF 0
-- Setcode: 11
--
-- Effect Text:
-- 自己场上有名字带有「永火」的怪兽表侧攻击表示存在，自己手卡是0张的场合才能发动。对方发动的效果怪兽的效果·魔法·陷阱卡的发动无效并破坏。
--[[ __CARD_HEADER_END__ ]]

--インフェルニティ・バリア
function c9059700.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_NEGATE+CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_CHAINING)
	e1:SetCondition(c9059700.condition)
	e1:SetTarget(c9059700.target)
	e1:SetOperation(c9059700.activate)
	c:RegisterEffect(e1)
end
function c9059700.cfilter(c)
	return c:IsPosition(POS_FACEUP_ATTACK) and c:IsSetCard(0xb)
end
function c9059700.condition(e,tp,eg,ep,ev,re,r,rp)
	if ep==tp or not Duel.IsExistingMatchingCard(c9059700.cfilter,tp,LOCATION_MZONE,0,1,nil)
		or Duel.GetFieldGroupCount(tp,LOCATION_HAND,0)~=0 then return false end
	return Duel.IsChainNegatable(ev) and (re:IsActiveType(TYPE_MONSTER) or re:IsHasType(EFFECT_TYPE_ACTIVATE))
end
function c9059700.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
	if re:GetHandler():IsDestructable() and re:GetHandler():IsRelateToEffect(re) then
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,1,0,0)
	end
end
function c9059700.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.NegateActivation(ev) and re:GetHandler():IsRelateToEffect(re) then
		Duel.Destroy(eg,REASON_EFFECT)
	end
end
