--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 搅乱作战  (ID: 77561728)
-- Type: Trap
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 对方将手卡加入卡组，再从卡组抽出与原本手卡数一样数目的卡。
--[[ __CARD_HEADER_END__ ]]

--攪乱作戦
function c77561728.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TODECK+CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMING_TOHAND)
	e1:SetTarget(c77561728.target)
	e1:SetOperation(c77561728.activate)
	c:RegisterEffect(e1)
end
function c77561728.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(1-tp)
		and Duel.IsExistingMatchingCard(Card.IsAbleToDeck,tp,0,LOCATION_HAND,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TODECK,nil,1,1-tp,LOCATION_HAND)
end
function c77561728.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetFieldGroup(tp,0,LOCATION_HAND)
	if g:GetCount()==0 then return end
	Duel.SendtoDeck(g,nil,SEQ_DECKSHUFFLE,REASON_EFFECT)
	Duel.ShuffleDeck(1-tp)
	Duel.BreakEffect()
	Duel.Draw(1-tp,g:GetCount(),REASON_EFFECT)
end
