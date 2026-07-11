--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:42
-- Source DB: cards.cdb
-- Card: Gagagarush  (ID: 13166204)
-- Type: Trap
-- Setcode: 0x54
-- Scope: OCG / TCG
--
-- Effect Text:
-- When a "Gagaga" monster(s) you control is targeted by the effect of an opponent's monster: Negate
-- the effect of that opponent's monster, and if you do, destroy it, then inflict damage to your
-- opponent equal to the destroyed monster's ATK or DEF in the GY (whichever is higher).
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
