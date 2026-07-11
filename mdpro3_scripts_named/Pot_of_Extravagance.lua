--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:47
-- Source DB: cards.cdb
-- Card: Pot of Extravagance  (ID: 49238328)
-- Type: Spell
-- Scope: OCG / TCG
--
-- Effect Text:
-- At the start of your Main Phase 1: Banish 3 or 6 random face-down cards from your Extra Deck,
-- face-down; draw 1 card for every 3 cards banished.
-- For the rest of this turn after this card resolves, you cannot draw any cards by card effects.
--[[ __CARD_HEADER_END__ ]]

--強欲で金満な壺
function c49238328.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c49238328.condition)
	e1:SetCost(c49238328.cost)
	e1:SetTarget(c49238328.target)
	e1:SetOperation(c49238328.activate)
	c:RegisterEffect(e1)
end
function c49238328.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetCurrentPhase()==PHASE_MAIN1 and not Duel.CheckPhaseActivity()
end
function c49238328.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	e:SetLabel(100)
	if chk==0 then return true end
end
function c49238328.cfilter(c)
	return c:IsFacedown() and c:IsAbleToRemoveAsCost(POS_FACEDOWN)
end
function c49238328.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local g=Duel.GetMatchingGroup(c49238328.cfilter,tp,LOCATION_EXTRA,0,nil)
	if chk==0 then
		if e:GetLabel()~=100 then return false end
		e:SetLabel(0)
		return Duel.IsPlayerCanDraw(tp,1) and #g>=3
	end
	local op=0
	if Duel.IsPlayerCanDraw(tp,2) and #g>=6 then
		op=Duel.SelectOption(tp,aux.Stringid(49238328,0),aux.Stringid(49238328,1))
	else
		op=Duel.SelectOption(tp,aux.Stringid(49238328,0))
	end
	Duel.ShuffleExtra(tp)
	local rg=g:RandomSelect(tp,3+op*3)
	Duel.Remove(rg,POS_FACEDOWN,REASON_COST)
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(op+1)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,op+1)
end
function c49238328.activate(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
	if not e:IsHasType(EFFECT_TYPE_ACTIVATE) then return end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_DRAW)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTargetRange(1,0)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
