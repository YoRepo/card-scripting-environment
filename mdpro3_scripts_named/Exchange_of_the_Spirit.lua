--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:43
-- Source DB: cards.cdb
-- Card: Exchange of the Spirit  (ID: 17484499)
-- Type: Trap
-- Scope: OCG / TCG
--
-- Effect Text:
-- If both players have 15 or more cards in their GYs: Pay 1000 LP; each player swaps the cards in
-- their GY with the cards in their Deck, then shuffles their Deck.
-- You can only activate 1 "Exchange of the Spirit" per Duel.
--[[ __CARD_HEADER_END__ ]]

--現世と冥界の逆転
function c17484499.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMING_DRAW_PHASE)
	e1:SetCountLimit(1,17484499+EFFECT_COUNT_CODE_DUEL+EFFECT_COUNT_CODE_OATH)
	e1:SetCondition(c17484499.condition)
	e1:SetCost(c17484499.cost)
	e1:SetOperation(c17484499.activate)
	c:RegisterEffect(e1)
end
function c17484499.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetFieldGroupCount(tp,LOCATION_GRAVE,0)>=15
		and Duel.GetFieldGroupCount(tp,0,LOCATION_GRAVE)>=15
end
function c17484499.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(tp,1000) end
	Duel.PayLPCost(tp,1000)
end
function c17484499.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetFieldGroup(tp,LOCATION_GRAVE,LOCATION_GRAVE)
	if aux.NecroValleyNegateCheck(g) then return end
	Duel.SwapDeckAndGrave(tp)
	Duel.SwapDeckAndGrave(1-tp)
end
