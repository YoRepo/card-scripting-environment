--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:49
-- Source DB: cards.cdb
-- Card: SPYRAL GEAR - Utility Wire  (ID: 53989821)
-- Type: Trap
-- Setcode: 0x10ee
-- Scope: OCG / TCG
--
-- Effect Text:
-- If you control "SPYRAL Super Agent": Target 1 face-up card your opponent controls; place it on top
-- of the Deck.
-- You can only activate 1 "SPYRAL GEAR - Utility Wire" per turn.
--[[ __CARD_HEADER_END__ ]]

--SPYRAL GEAR－マルチワイヤー
function c53989821.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TODECK)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,53989821+EFFECT_COUNT_CODE_OATH)
	e1:SetHintTiming(0,TIMINGS_CHECK_MONSTER+TIMING_END_PHASE)
	e1:SetCondition(c53989821.condition)
	e1:SetTarget(c53989821.target)
	e1:SetOperation(c53989821.activate)
	c:RegisterEffect(e1)
end
function c53989821.cfilter(c)
	return c:IsFaceup() and c:IsCode(41091257)
end
function c53989821.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c53989821.cfilter,tp,LOCATION_ONFIELD,0,1,nil)
end
function c53989821.filter(c)
	return c:IsFaceup() and c:IsAbleToDeck()
end
function c53989821.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(1-tp) and chkc:IsOnField() and c53989821.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c53989821.filter,tp,0,LOCATION_ONFIELD,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g=Duel.SelectTarget(tp,c53989821.filter,tp,0,LOCATION_ONFIELD,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,g,1,0,0)
end
function c53989821.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SendtoDeck(tc,nil,SEQ_DECKTOP,REASON_EFFECT)
	end
end
