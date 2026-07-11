--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:50
-- Source DB: cards.cdb
-- Card: Self-Destruct Button  (ID: 57585212)
-- Type: Trap
-- Scope: OCG / TCG
--
-- Effect Text:
-- You can only activate this card while your Life Points are lower than your opponent's Life Points
-- and the difference is 7000 points or more.
-- Both players' Life Points become 0.
--[[ __CARD_HEADER_END__ ]]

--自爆スイッチ
function c57585212.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c57585212.condition)
	e1:SetOperation(c57585212.activate)
	c:RegisterEffect(e1)
end
function c57585212.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetLP(tp)<=Duel.GetLP(1-tp)-7000
end
function c57585212.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.SetLP(tp,0)
	Duel.SetLP(1-tp,0)
end
