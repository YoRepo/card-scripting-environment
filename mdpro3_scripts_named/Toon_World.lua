--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:43
-- Source DB: cards.cdb
-- Card: Toon World  (ID: 15259703)
-- Type: Spell / Continuous
-- Setcode: 0x62
-- Scope: OCG / TCG
--
-- Effect Text:
-- Activate this card by paying 1000 LP.
--[[ __CARD_HEADER_END__ ]]

--トゥーン・ワールド
function c15259703.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c15259703.cost)
	c:RegisterEffect(e1)
end
function c15259703.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(tp,1000) end
	Duel.PayLPCost(tp,1000)
end
