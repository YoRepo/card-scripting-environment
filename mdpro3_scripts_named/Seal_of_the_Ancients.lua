--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:37
-- Card: 旧神之印  (ID: 97809599)
-- Type: Spell
-- ATK 0 | DEF 0
--
-- Effect Text:
-- ①：支付1000基本分才能发动。对方场上盖放的卡全部确认。
--[[ __CARD_HEADER_END__ ]]

--旧神の印
function c97809599.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c97809599.cost)
	e1:SetTarget(c97809599.target)
	e1:SetOperation(c97809599.activate)
	c:RegisterEffect(e1)
end
function c97809599.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(tp,1000) end
	Duel.PayLPCost(tp,1000)
end
function c97809599.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsFacedown,tp,0,LOCATION_ONFIELD,1,nil) end
end
function c97809599.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(Card.IsFacedown,tp,0,LOCATION_ONFIELD,nil)
	if g:GetCount()>0 then
		Duel.ConfirmCards(tp,g)
	end
end
