--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 物质龙  (ID: 12298909)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Dragon
-- Level 6
-- ATK 2400 | DEF 2000
--
-- Effect Text:
-- 只要这张卡在自己场上表侧表示存在，给与基本分伤害的效果变成基本分回复的效果。此外，持有「把场上的怪兽破坏的效果」的魔法·陷阱·效果怪兽的效果发动时，可以把1张手卡送去墓地让那个发动无效并破坏。
--[[ __CARD_HEADER_END__ ]]

--マテリアルドラゴン
function c12298909.initial_effect(c)
	--Negate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(12298909,0))
	e1:SetCategory(CATEGORY_NEGATE+CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_CHAINING)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(c12298909.condition)
	e1:SetCost(c12298909.cost)
	e1:SetTarget(c12298909.target)
	e1:SetOperation(c12298909.operation)
	c:RegisterEffect(e1)
	--damage conversion
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetCode(EFFECT_REVERSE_DAMAGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(1,1)
	e2:SetValue(c12298909.rev)
	c:RegisterEffect(e2)
end
function c12298909.rev(e,re,r,rp,rc)
	return bit.band(r,REASON_EFFECT)>0
end
function c12298909.filter(c)
	return c:IsOnField() and c:IsType(TYPE_MONSTER)
end
function c12298909.condition(e,tp,eg,ep,ev,re,r,rp)
	if e==re or e:GetHandler():IsStatus(STATUS_BATTLE_DESTROYED) or not Duel.IsChainNegatable(ev) then return false end
	local ex,tg,tc=Duel.GetOperationInfo(ev,CATEGORY_DESTROY)
	return ex and tg~=nil and tc+tg:FilterCount(c12298909.filter,nil)-tg:GetCount()>0
end
function c12298909.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsAbleToGraveAsCost,tp,LOCATION_HAND,0,1,nil) end
	Duel.DiscardHand(tp,Card.IsAbleToGraveAsCost,1,1,REASON_COST)
end
function c12298909.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
	if re:GetHandler():IsDestructable() and re:GetHandler():IsRelateToEffect(re) then
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,1,0,0)
	end
end
function c12298909.operation(e,tp,eg,ep,ev,re,r,rp)
	if Duel.NegateActivation(ev) and re:GetHandler():IsRelateToEffect(re) then
		Duel.Destroy(eg,REASON_EFFECT)
	end
end
