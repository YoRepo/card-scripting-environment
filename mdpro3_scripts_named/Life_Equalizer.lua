--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:43
-- Source DB: cards.cdb
-- Card: Life Equalizer  (ID: 17178486)
-- Type: Trap
-- Scope: OCG / TCG
--
-- Effect Text:
-- Activate only when the difference between both players' Life Points is 8000 or more.
-- Both players' Life Points become 3000.
--[[ __CARD_HEADER_END__ ]]

--ライフチェンジャー
function c17178486.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c17178486.condition)
	e1:SetOperation(c17178486.activate)
	c:RegisterEffect(e1)
end
function c17178486.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetLP(tp)-Duel.GetLP(1-tp)>=8000 or Duel.GetLP(1-tp)-Duel.GetLP(tp)>=8000
end
function c17178486.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.SetLP(tp,3000)
	Duel.SetLP(1-tp,3000)
end
