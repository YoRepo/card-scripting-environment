--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:51
-- Source DB: cards.cdb
-- Card: Exterio's Fang  (ID: 68456353)
-- Type: Trap / Counter
-- Scope: OCG / TCG
--
-- Effect Text:
-- When your opponent activates a Spell/Trap Card while you control a "Naturia" monster and have at
-- least 1 card in your hand: Negate the activation, and if you do, destroy it, then, send 1 card from
-- your hand to the GY.
--[[ __CARD_HEADER_END__ ]]

--エクストリオの牙
function c68456353.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_NEGATE+CATEGORY_DESTROY+CATEGORY_TOGRAVE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_CHAINING)
	e1:SetCondition(c68456353.condition)
	e1:SetTarget(c68456353.target)
	e1:SetOperation(c68456353.activate)
	c:RegisterEffect(e1)
end
function c68456353.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x2a)
end
function c68456353.condition(e,tp,eg,ep,ev,re,r,rp)
	return re:IsHasType(EFFECT_TYPE_ACTIVATE) and rp==1-tp and Duel.IsChainNegatable(ev)
		and Duel.IsExistingMatchingCard(c68456353.cfilter,tp,LOCATION_MZONE,0,1,nil)
end
function c68456353.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFieldGroupCount(tp,LOCATION_HAND,0)>0 end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
	if re:GetHandler():IsDestructable() and re:GetHandler():IsRelateToEffect(re) then
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,1,0,0)
	end
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,1,tp,LOCATION_HAND)
end
function c68456353.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.NegateActivation(ev) and re:GetHandler():IsRelateToEffect(re) then
		Duel.Destroy(eg,REASON_EFFECT)
	end
	Duel.DiscardHand(tp,nil,1,1,REASON_EFFECT,nil)
end
