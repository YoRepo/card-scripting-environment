--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:51
-- Source DB: cards.cdb
-- Card: Mind Haxorz  (ID: 75392615)
-- Type: Trap
-- Scope: OCG / TCG
--
-- Effect Text:
-- Pay 500 Life Points.
-- Look at your opponent's hand and all Set cards on their side of the field.
--[[ __CARD_HEADER_END__ ]]

--マインド・ハック
function c75392615.initial_effect(c)
	--confirm
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c75392615.cost)
	e1:SetTarget(c75392615.target)
	e1:SetOperation(c75392615.operation)
	c:RegisterEffect(e1)
end
function c75392615.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(tp,500) end
	Duel.PayLPCost(tp,500)
end
function c75392615.filter(c)
	return (c:IsOnField() and c:IsFacedown()) or (c:IsLocation(LOCATION_HAND) and not c:IsPublic())
end
function c75392615.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c75392615.filter,tp,0,LOCATION_HAND+LOCATION_ONFIELD,1,nil) end
end
function c75392615.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c75392615.filter,tp,0,LOCATION_HAND+LOCATION_ONFIELD,nil)
	Duel.ConfirmCards(tp,g)
	Duel.ShuffleHand(1-tp)
end
