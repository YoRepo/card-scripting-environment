--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:49
-- Source DB: cards.cdb
-- Card: Ultimate Fire Formation - Sinto  (ID: 55538156)
-- Type: Trap / Counter
-- Setcode: 0x7c
-- Scope: OCG / TCG
--
-- Effect Text:
-- When a Spell/Trap Card is activated, while you control a "Fire Fist" monster and a "Fire Formation"
-- Spell/Trap: Negate the activation, and if you do, destroy that card.
-- You can only activate 1 "Ultimate Fire Formation - Sinto" per turn.
--[[ __CARD_HEADER_END__ ]]

--極炎舞－「辰斗」
function c55538156.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_NEGATE+CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_CHAINING)
	e1:SetCountLimit(1,55538156+EFFECT_COUNT_CODE_OATH)
	e1:SetCondition(c55538156.condition)
	e1:SetTarget(c55538156.target)
	e1:SetOperation(c55538156.activate)
	c:RegisterEffect(e1)
end
function c55538156.cfilter1(c)
	return c:IsFaceup() and c:IsSetCard(0x79)
end
function c55538156.cfilter2(c)
	return c:IsFaceup() and c:IsSetCard(0x7c) and c:IsType(TYPE_SPELL+TYPE_TRAP)
end
function c55538156.condition(e,tp,eg,ep,ev,re,r,rp)
	return re:IsHasType(EFFECT_TYPE_ACTIVATE) and Duel.IsChainNegatable(ev)
		and Duel.IsExistingMatchingCard(c55538156.cfilter1,tp,LOCATION_MZONE,0,1,nil)
		and Duel.IsExistingMatchingCard(c55538156.cfilter2,tp,LOCATION_ONFIELD,0,1,nil)
end
function c55538156.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	if re:GetHandler():IsRelateToEffect(re) and re:GetHandler():IsDestructable() then
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,re:GetHandler(),1,0,0)
	end
end
function c55538156.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.NegateActivation(ev) and re:GetHandler():IsRelateToEffect(re) then
		Duel.Destroy(re:GetHandler(),REASON_EFFECT)
	end
end
