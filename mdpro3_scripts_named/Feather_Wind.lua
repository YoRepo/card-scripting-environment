--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 羽翼之风  (ID: 71060915)
-- Type: Trap / Flip
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 自己场上有「元素英雄 羽翼侠」表侧表示存在的场合才能发动。魔法·陷阱卡的发动无效，并把那张卡破坏。
--[[ __CARD_HEADER_END__ ]]

--フェザー・ウィンド
function c71060915.initial_effect(c)
	aux.AddSetNameMonsterList(c,0x3008)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_NEGATE+CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_CHAINING)
	e1:SetCondition(c71060915.condition)
	e1:SetTarget(c71060915.target)
	e1:SetOperation(c71060915.activate)
	c:RegisterEffect(e1)
end
function c71060915.filter(c)
	return c:IsFaceup() and c:IsCode(21844576)
end
function c71060915.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c71060915.filter,tp,LOCATION_ONFIELD,0,1,nil)
		and re:IsHasType(EFFECT_TYPE_ACTIVATE) and Duel.IsChainNegatable(ev)
end
function c71060915.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
	if re:GetHandler():IsDestructable() and re:GetHandler():IsRelateToEffect(re) then
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,1,0,0)
	end
end
function c71060915.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.NegateActivation(ev) and re:GetHandler():IsRelateToEffect(re) then
		Duel.Destroy(eg,REASON_EFFECT)
	end
end
