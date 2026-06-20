--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:30
-- Card: 妖仙兽的秘技  (ID: 54903668)
-- Type: Trap / Flip
-- ATK 0 | DEF 0
-- Setcode: 179
--
-- Effect Text:
-- ①：自己场上有「妖仙兽」卡存在，自己的怪兽区域没有「妖仙兽」怪兽以外的表侧表示怪兽存在的场合，怪兽的效果·魔法·陷阱卡发动时才能发动。那个发动无效并破坏。
--[[ __CARD_HEADER_END__ ]]

--妖仙獣の秘技
function c54903668.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_NEGATE+CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_CHAINING)
	e1:SetCondition(c54903668.condition)
	e1:SetTarget(c54903668.target)
	e1:SetOperation(c54903668.activate)
	c:RegisterEffect(e1)
end
function c54903668.filter1(c)
	return c:IsFaceup() and c:IsSetCard(0xb3)
end
function c54903668.filter2(c)
	return c:IsFaceup() and not c:IsSetCard(0xb3)
end
function c54903668.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c54903668.filter1,tp,LOCATION_ONFIELD,0,1,nil)
		and not Duel.IsExistingMatchingCard(c54903668.filter2,tp,LOCATION_MZONE,0,1,nil)
		and (re:IsActiveType(TYPE_MONSTER) or re:IsHasType(EFFECT_TYPE_ACTIVATE)) and Duel.IsChainNegatable(ev)
end
function c54903668.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
	if re:GetHandler():IsDestructable() and re:GetHandler():IsRelateToEffect(re) then
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,1,0,0)
	end
end
function c54903668.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.NegateActivation(ev) and re:GetHandler():IsRelateToEffect(re) then
		Duel.Destroy(eg,REASON_EFFECT)
	end
end
