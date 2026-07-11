--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:44
-- Source DB: cards.cdb
-- Card: Magical Musket - Last Stand  (ID: 29628180)
-- Type: Trap / Counter
-- Setcode: 0x108
-- Scope: OCG / TCG
--
-- Effect Text:
-- When your opponent activates a Spell/Trap Card while you control a "Magical Musket" monster: Negate
-- the activation, and if you do, destroy that card.
-- You can only activate 1 "Magical Musket - Last Stand" per turn.
--[[ __CARD_HEADER_END__ ]]

--魔弾－デッドマンズ・バースト
function c29628180.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_NEGATE+CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_CHAINING)
	e1:SetCountLimit(1,29628180+EFFECT_COUNT_CODE_OATH)
	e1:SetCondition(c29628180.condition)
	e1:SetTarget(c29628180.target)
	e1:SetOperation(c29628180.activate)
	c:RegisterEffect(e1)
end
function c29628180.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x108)
end
function c29628180.condition(e,tp,eg,ep,ev,re,r,rp)
	return rp==1-tp and re:IsHasType(EFFECT_TYPE_ACTIVATE) and Duel.IsChainNegatable(ev)
		and Duel.IsExistingMatchingCard(c29628180.cfilter,tp,LOCATION_MZONE,0,1,nil)
end
function c29628180.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
	if re:GetHandler():IsDestructable() and re:GetHandler():IsRelateToEffect(re) then
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,1,0,0)
	end
end
function c29628180.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.NegateActivation(ev) and re:GetHandler():IsRelateToEffect(re) then
		Duel.Destroy(eg,REASON_EFFECT)
	end
end
