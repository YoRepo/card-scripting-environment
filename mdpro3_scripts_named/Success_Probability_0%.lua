--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:51
-- Source DB: cards.cdb
-- Card: Success Probability 0%  (ID: 6859683)
-- Type: Trap
-- Scope: OCG / TCG
--
-- Effect Text:
-- Send 2 random Fusion Monsters from your opponent's Extra Deck to the Graveyard.
--[[ __CARD_HEADER_END__ ]]

--成功確率0％
function c6859683.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_REMOVE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c6859683.target)
	e1:SetOperation(c6859683.operation)
	c:RegisterEffect(e1)
end
function c6859683.filter(c)
	return (c:IsFacedown() or c:IsType(TYPE_FUSION)) and c:IsAbleToGrave()
end
function c6859683.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local g=Duel.GetFieldGroup(tp,0,LOCATION_EXTRA)
	if chk==0 then return g:FilterCount(c6859683.filter,nil)>=2 end
end
function c6859683.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(Card.IsType,1-tp,LOCATION_EXTRA,0,nil,TYPE_FUSION)
	if g:GetCount()<2 then return end
	local rg=g:RandomSelect(tp,2)
	Duel.SendtoGrave(rg,REASON_EFFECT)
end
