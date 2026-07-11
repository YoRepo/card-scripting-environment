--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:49
-- Source DB: cards.cdb
-- Card: Yosenjus' Secret Move  (ID: 54903668)
-- Type: Trap / Counter
-- Setcode: 0xb3
-- Scope: OCG / TCG
--
-- Effect Text:
-- When a Spell/Trap Card, or monster effect, is activated while you control at least 1 "Yosenju" card,
-- and all face-up monsters you control are "Yosenju" monsters: Negate the activation, and if you do,
-- destroy that card.
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
