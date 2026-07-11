--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:54
-- Source DB: cards.cdb
-- Card: Xyz Wrath  (ID: 99064191)
-- Type: Trap / Continuous
-- Setcode: 0x73
-- Scope: OCG / TCG
--
-- Effect Text:
-- Once per turn, when a Level 5 or higher monster's effect is activated (except during the Damage
-- Step), and you control an Xyz Monster: You can discard 1 card; negate the effect, and if you do,
-- destroy that monster.
--[[ __CARD_HEADER_END__ ]]

--エクシーズ・パニッシュ
function c99064191.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--negate
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(99064191,0))
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCode(EVENT_CHAINING)
	e2:SetCountLimit(1)
	e2:SetCondition(c99064191.condition)
	e2:SetCost(c99064191.cost)
	e2:SetTarget(c99064191.target)
	e2:SetOperation(c99064191.activate)
	c:RegisterEffect(e2)
end
function c99064191.cfilter(c)
	return c:IsFaceup() and c:IsType(TYPE_XYZ)
end
function c99064191.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c99064191.cfilter,tp,LOCATION_MZONE,0,1,nil)
		and re:IsActiveType(TYPE_EFFECT) and re:GetHandler():IsLevelAbove(5) and Duel.IsChainDisablable(ev)
end
function c99064191.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsDiscardable,tp,LOCATION_HAND,0,1,nil) end
	Duel.DiscardHand(tp,Card.IsDiscardable,1,1,REASON_COST+REASON_DISCARD)
end
function c99064191.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DISABLE,eg,1,0,0)
	if re:GetHandler():IsDestructable() and re:GetHandler():IsRelateToEffect(re) then
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,1,0,0)
	end
end
function c99064191.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.NegateEffect(ev) and re:GetHandler():IsRelateToEffect(re) then
		Duel.Destroy(eg,REASON_EFFECT)
	end
end
