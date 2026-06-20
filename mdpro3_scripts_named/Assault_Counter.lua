--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 爆裂反击  (ID: 76407432)
-- Type: Trap / Flip
-- ATK 0 | DEF 0
-- Setcode: 409
--
-- Effect Text:
-- ①：自己场上有「/爆裂体」怪兽存在，怪兽的效果·魔法·陷阱卡发动时才能发动。那个发动无效并破坏。
--[[ __CARD_HEADER_END__ ]]

--バスター・カウンター
function c76407432.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_NEGATE+CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_CHAINING)
	e1:SetCondition(c76407432.condition)
	e1:SetTarget(c76407432.target)
	e1:SetOperation(c76407432.activate)
	c:RegisterEffect(e1)
end
function c76407432.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x104f)
end
function c76407432.condition(e,tp,eg,ep,ev,re,r,rp)
	if not Duel.IsExistingMatchingCard(c76407432.cfilter,tp,LOCATION_MZONE,0,1,nil) then return false end
	if not Duel.IsChainNegatable(ev) then return false end
	return re:IsActiveType(TYPE_MONSTER) or re:IsHasType(EFFECT_TYPE_ACTIVATE)
end
function c76407432.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
	if re:GetHandler():IsDestructable() and re:GetHandler():IsRelateToEffect(re) then
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,1,0,0)
	end
end
function c76407432.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.NegateActivation(ev) and re:GetHandler():IsRelateToEffect(re) then
		Duel.Destroy(eg,REASON_EFFECT)
	end
end
