--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:37
-- Card: 哥布林的经营手腕  (ID: 9744376)
-- Type: Trap
-- ATK 0 | DEF 0
-- Setcode: 172
--
-- Effect Text:
-- 从卡组抽自己墓地存在的「哥布林的经营手腕」的数量＋1的卡，选择1张手卡放回到卡组最下面。
--[[ __CARD_HEADER_END__ ]]

--ゴブリンのやりくり上手
function c9744376.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DRAW+CATEGORY_TODECK)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c9744376.target)
	e1:SetOperation(c9744376.activate)
	c:RegisterEffect(e1)
end
function c9744376.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,1) end
	Duel.SetTargetPlayer(tp)
	local ct=Duel.GetMatchingGroupCount(Card.IsCode,tp,LOCATION_GRAVE,0,nil,9744376)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,ct+1)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,nil,1,tp,LOCATION_HAND)
end
function c9744376.activate(e,tp,eg,ep,ev,re,r,rp)
	local p=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER)
	local d=Duel.GetMatchingGroupCount(Card.IsCode,p,LOCATION_GRAVE,0,nil,9744376)+1
	Duel.Draw(p,d,REASON_EFFECT)
	Duel.BreakEffect()
	Duel.ShuffleHand(tp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g=Duel.SelectMatchingCard(p,aux.TRUE,p,LOCATION_HAND,0,1,1,nil)
	Duel.SendtoDeck(g,nil,SEQ_DECKBOTTOM,REASON_EFFECT)
end
