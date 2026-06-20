--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 借机巧整备藏  (ID: 2924048)
-- Type: Trap / Flip
-- ATK 0 | DEF 0
-- Setcode: 17
--
-- Effect Text:
-- 自己场上有名字带有「机巧」的怪兽表侧守备表示存在的场合才能发动。对方发动的魔法·陷阱卡的发动无效并破坏。
--[[ __CARD_HEADER_END__ ]]

--借カラクリ整備蔵
function c2924048.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_NEGATE+CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_CHAINING)
	e1:SetCondition(c2924048.condition)
	e1:SetTarget(c2924048.target)
	e1:SetOperation(c2924048.activate)
	c:RegisterEffect(e1)
end
function c2924048.cfilter(c)
	return c:IsPosition(POS_FACEUP_DEFENSE) and c:IsSetCard(0x11)
end
function c2924048.condition(e,tp,eg,ep,ev,re,r,rp)
	if ep==tp or not Duel.IsExistingMatchingCard(c2924048.cfilter,tp,LOCATION_MZONE,0,1,nil) then return false end
	return re:IsHasType(EFFECT_TYPE_ACTIVATE) and Duel.IsChainNegatable(ev)
end
function c2924048.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
	if re:GetHandler():IsDestructable() and re:GetHandler():IsRelateToEffect(re) then
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,1,0,0)
	end
end
function c2924048.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.NegateActivation(ev) and re:GetHandler():IsRelateToEffect(re) then
		Duel.Destroy(eg,REASON_EFFECT)
	end
end
