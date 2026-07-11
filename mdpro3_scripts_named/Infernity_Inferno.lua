--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:43
-- Source DB: cards.cdb
-- Card: Infernity Inferno  (ID: 14550855)
-- Type: Trap
-- Setcode: 0xb
-- Scope: OCG / TCG
--
-- Effect Text:
-- Discard up to 2 cards, and send the same number of "Infernity" cards from your Deck to the
-- Graveyard.
--[[ __CARD_HEADER_END__ ]]

--インフェルニティ・インフェルノ
function c14550855.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_HANDES_SELF+CATEGORY_TOGRAVE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c14550855.target)
	e1:SetOperation(c14550855.activate)
	c:RegisterEffect(e1)
end
function c14550855.filter(c)
	return c:IsSetCard(0xb) and c:IsAbleToGrave()
end
function c14550855.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFieldGroupCount(tp,LOCATION_HAND,0)>0
		and Duel.IsExistingMatchingCard(c14550855.filter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_HANDES_SELF,nil,0,tp,1)
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,1,tp,LOCATION_DECK)
end
function c14550855.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetFieldGroupCount(tp,LOCATION_HAND,0)==0 then return end
	local ac=Duel.GetMatchingGroupCount(c14550855.filter,tp,LOCATION_DECK,0,nil)
	if ac==0 then return end
	if ac>2 then ac=2 end
	local ct=Duel.DiscardHand(tp,aux.TRUE,1,ac,REASON_DISCARD+REASON_EFFECT)
	Duel.BreakEffect()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c14550855.filter,tp,LOCATION_DECK,0,1,ct,nil)
	Duel.SendtoGrave(g,REASON_EFFECT)
end
