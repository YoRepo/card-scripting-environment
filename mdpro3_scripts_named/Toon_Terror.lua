--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:48
-- Source DB: cards.cdb
-- Card: Toon Terror  (ID: 53094821)
-- Type: Trap / Counter
-- Setcode: 0x62
-- Scope: OCG / TCG
--
-- Effect Text:
-- When a Spell/Trap Card, or monster effect, is activated, while you control both "Toon World" and a
-- Toon monster(s): Negate the activation, and if you do, destroy that card.
-- You can only activate 1 "Toon Terror" per turn.
--[[ __CARD_HEADER_END__ ]]

--トゥーン・テラー
function c53094821.initial_effect(c)
	aux.AddCodeList(c,15259703)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_NEGATE+CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_CHAINING)
	e1:SetCountLimit(1,53094821+EFFECT_COUNT_CODE_OATH)
	e1:SetCondition(c53094821.condition)
	e1:SetTarget(c53094821.target)
	e1:SetOperation(c53094821.activate)
	c:RegisterEffect(e1)
end
function c53094821.cfilter1(c)
	return c:IsFaceup() and c:IsCode(15259703)
end
function c53094821.cfilter2(c)
	return c:IsFaceup() and c:IsType(TYPE_TOON)
end
function c53094821.condition(e,tp,eg,ep,ev,re,r,rp)
	return (re:IsActiveType(TYPE_MONSTER) or re:IsHasType(EFFECT_TYPE_ACTIVATE)) and Duel.IsChainNegatable(ev)
		and Duel.IsExistingMatchingCard(c53094821.cfilter1,tp,LOCATION_ONFIELD,0,1,nil)
		and Duel.IsExistingMatchingCard(c53094821.cfilter2,tp,LOCATION_MZONE,0,1,nil)
end
function c53094821.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
	if re:GetHandler():IsRelateToEffect(re) and re:GetHandler():IsDestructable() then
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,1,0,0)
	end
end
function c53094821.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.NegateActivation(ev) and re:GetHandler():IsRelateToEffect(re) then
		Duel.Destroy(eg,REASON_EFFECT)
	end
end
