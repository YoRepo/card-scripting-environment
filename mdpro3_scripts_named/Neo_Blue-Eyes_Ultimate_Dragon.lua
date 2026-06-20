--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:31
-- Card: 真青眼究极龙  (ID: 56532353)
-- Type: Monster / Effect / Fusion
-- Attribute: LIGHT
-- Race: Dragon
-- Level 12
-- ATK 4500 | DEF 3800
-- Setcode: 221
--
-- Effect Text:
-- 「青眼白龙」＋「青眼白龙」＋「青眼白龙」
-- 这个卡名的①的效果1回合可以使用最多2次。
-- ①：融合召唤的这张卡攻击的伤害步骤结束时，自己场上没有其他的表侧表示卡存在的场合，从额外卡组把1只「青眼」融合怪兽送去墓地才能发动。这张卡可以继续攻击。
-- ②：自己场上的「青眼」怪兽为对象的魔法·陷阱·怪兽的效果发动时，把墓地的这张卡除外才能发动。那个发动无效并破坏。
--[[ __CARD_HEADER_END__ ]]

--真青眼の究極竜
function c56532353.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCodeRep(c,89631139,3,true,true)
	--chain attack
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_DAMAGE_STEP_END)
	e1:SetCountLimit(2,56532353)
	e1:SetCondition(c56532353.atcon)
	e1:SetCost(c56532353.atcost)
	e1:SetOperation(c56532353.atop)
	c:RegisterEffect(e1)
	--Negate
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_NEGATE+CATEGORY_DESTROY)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_CHAINING)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e2:SetCondition(c56532353.condition)
	e2:SetCost(aux.bfgcost)
	e2:SetTarget(c56532353.target)
	e2:SetOperation(c56532353.operation)
	c:RegisterEffect(e2)
end
function c56532353.costfilter(c)
	return c:IsSetCard(0xdd) and c:IsType(TYPE_FUSION) and c:IsAbleToGraveAsCost()
end
function c56532353.atcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsSummonType(SUMMON_TYPE_FUSION)
		and Duel.GetAttacker()==c and c:IsChainAttackable(0)
		and not Duel.IsExistingMatchingCard(Card.IsFaceup,tp,LOCATION_ONFIELD,0,1,c)
end
function c56532353.atcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c56532353.costfilter,tp,LOCATION_EXTRA,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c56532353.costfilter,tp,LOCATION_EXTRA,0,1,1,nil)
	Duel.SendtoGrave(g,REASON_COST)
end
function c56532353.atop(e,tp,eg,ep,ev,re,r,rp)
	Duel.ChainAttack()
end
function c56532353.filter(c,tp)
	return c:IsControler(tp) and c:IsLocation(LOCATION_MZONE) and c:IsFaceup() and c:IsSetCard(0xdd)
end
function c56532353.condition(e,tp,eg,ep,ev,re,r,rp)
	if not re:IsHasProperty(EFFECT_FLAG_CARD_TARGET) then return false end
	local g=Duel.GetChainInfo(ev,CHAININFO_TARGET_CARDS)
	return g and g:IsExists(c56532353.filter,1,nil,tp)
		and Duel.IsChainNegatable(ev)
end
function c56532353.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
	if re:GetHandler():IsDestructable() and re:GetHandler():IsRelateToEffect(re) then
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,1,0,0)
	end
end
function c56532353.operation(e,tp,eg,ep,ev,re,r,rp)
	if Duel.NegateActivation(ev) and re:GetHandler():IsRelateToEffect(re) then
		Duel.Destroy(eg,REASON_EFFECT)
	end
end
