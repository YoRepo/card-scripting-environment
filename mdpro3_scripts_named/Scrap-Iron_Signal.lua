--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:48
-- Source DB: cards.cdb
-- Card: Scrap-Iron Signal  (ID: 50947142)
-- Type: Trap / Counter
-- Scope: OCG / TCG
--
-- Effect Text:
-- When your opponent activates a monster effect, while you control a Synchro Monster that mentions a
-- Synchro Monster as material: Negate the activation, also, after that, Set this card face-down
-- instead of sending it to the GY.
-- You can only activate 1 "Scrap-Iron Signal" per turn.
--[[ __CARD_HEADER_END__ ]]

--くず鉄のシグナル
function c50947142.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_NEGATE+CATEGORY_SSET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_CHAINING)
	e1:SetCountLimit(1,50947142+EFFECT_COUNT_CODE_OATH)
	e1:SetCondition(c50947142.condition)
	e1:SetTarget(c50947142.target)
	e1:SetOperation(c50947142.activate)
	c:RegisterEffect(e1)
end
function c50947142.filter(c)
	return c:IsType(TYPE_SYNCHRO) and aux.IsMaterialListType(c,TYPE_SYNCHRO) and c:IsFaceup()
end
function c50947142.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c50947142.filter,tp,LOCATION_MZONE,0,1,nil)
		and re:IsActiveType(TYPE_MONSTER) and Duel.IsChainNegatable(ev) and rp==1-tp
end
function c50947142.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
end
function c50947142.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateActivation(ev)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and c:IsCanTurnSet() then
		Duel.BreakEffect()
		c:CancelToGrave()
		Duel.ChangePosition(c,POS_FACEDOWN)
		Duel.RaiseEvent(c,EVENT_SSET,e,REASON_EFFECT,tp,tp,0)
	end
end
