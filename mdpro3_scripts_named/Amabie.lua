--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:43
-- Source DB: cards.cdb
-- Card: Amabie  (ID: 2139640)
-- Type: Monster / Effect
-- Attribute: WATER
-- Race: Fairy
-- Level: 3
-- ATK 0 | DEF 0
-- Scope: OCG / TCG
--
-- Effect Text:
-- At the start of your Main Phase 1: You can reveal this card in your hand; each player gains 300 LP.
--[[ __CARD_HEADER_END__ ]]

--あまびえさん
function c2139640.initial_effect(c)
	--recover
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(2139640,0))
	e1:SetCategory(CATEGORY_RECOVER)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c2139640.condition)
	e1:SetCost(c2139640.cost)
	e1:SetTarget(c2139640.target)
	e1:SetOperation(c2139640.operation)
	c:RegisterEffect(e1)
end
function c2139640.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetCurrentPhase()==PHASE_MAIN1 and not Duel.CheckPhaseActivity()
end
function c2139640.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return not e:GetHandler():IsPublic() end
end
function c2139640.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_RECOVER,nil,0,PLAYER_ALL,300)
end
function c2139640.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.Recover(tp,300,REASON_EFFECT)
	Duel.Recover(1-tp,300,REASON_EFFECT)
end
