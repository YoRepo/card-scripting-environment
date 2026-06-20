--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 我我我突击  (ID: 13166204)
-- Type: Trap
-- ATK 0 | DEF 0
-- Setcode: 84
--
-- Effect Text:
-- 自己场上的名字带有「我我我」的怪兽成为对方怪兽的效果的对象时才能发动。那只对方怪兽的效果无效并破坏。那之后，给与对方基本分破坏的怪兽的攻击力和守备力之内较高方数值的伤害。
--[[ __CARD_HEADER_END__ ]]

--ガガガラッシュ
function c13166204.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DAMAGE+CATEGORY_NEGATE+CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_BECOME_TARGET)
	e1:SetCondition(c13166204.condition)
	e1:SetTarget(c13166204.target)
	e1:SetOperation(c13166204.activate)
	c:RegisterEffect(e1)
end
function c13166204.filter(c,tp)
	return c:IsFaceup() and c:IsControler(tp) and c:IsLocation(LOCATION_MZONE) and c:IsSetCard(0x54)
end
function c13166204.condition(e,tp,eg,ep,ev,re,r,rp)
	return rp==1-tp and re:IsActiveType(TYPE_MONSTER) and eg:IsExists(c13166204.filter,1,nil,tp) and Duel.IsChainDisablable(ev)
end
function c13166204.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DISABLE,eg,1,0,0)
	if re:GetHandler():IsDestructable() and re:GetHandler():IsRelateToEffect(re) then
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,re:GetHandler(),1,0,0)
		Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,0)
	end
end
function c13166204.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.NegateEffect(ev) and re:GetHandler():IsRelateToEffect(re) and Duel.Destroy(re:GetHandler(),REASON_EFFECT)~=0 then
		local a=re:GetHandler():GetAttack()
		local b=re:GetHandler():GetDefense()
		if b>a then a=b end
		if a>0 then
			Duel.BreakEffect()
			Duel.Damage(1-tp,a,REASON_EFFECT)
		end
	end
end
